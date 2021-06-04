class UsersController < ApplicationController
  before_action :authorized

  # function : index
  # show user list
  # return : @users
  def index
    @users = UserService.getAllUserList
  end

  # function : new
  # show create user page
  # return : @user
  def new
    @user = User.new()
  end

  # function : show
  # show user detail
  # params : id
  # return : @user
  def show
    @user = UserService.getUserById(params[:id])
  end

  # function : create
  # create new user
  # params : user_params
  def create
    @user = User.new(user_params)

    isSaveUser = UserService.createUser(@user)
    respond_to do |format|
      if isSaveUser
        format.html { redirect_to users_path, notice: Messages::CREATE_SUCCESSFUL }
        format.json { render :index, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # function : create_confirm
  # confirm user create
  # params : user_params
  # return : user
  def create_confirm
    @user = User.new(user_params)
    unless @user.valid?
      render new_user_path      
    end
    if user_params.has_key?(:profile)
      dir = "#{Rails.root}/app/assets/profiles"
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
      profileName = user_params[:name] + "_" + Time.now.strftime('%Y%m%d_%H%M%S') +"." + ActiveStorage::Filename.new(user_params[:profile].original_filename).extension
      File.open(Rails.root.join('app/assets/', 'images', profileName), 'wb') do |f|
        f.write(user_params[:profile].read)
      end
      @user.profile = profileName
    end
  end

  # function : profile
  # show user profile
  # params : id
  # return : @user
  def profile
    @user = UserService.getUserById(params[:id])
  end

  # form : edit_profile
  # show profile edit form
  # params : id
  # return : user_form
  def edit_profile
    @user = UserService.getUserById(params[:id])
    @profile_form = ProfileForm.new(ProfileForm.initialize(@user, :new_profile))
  end

  # function : update_profile
  # update user profile
  # params : profile_params
  def update_profile
    @profile_form = ProfileForm.new(profile_params)
    if !@profile_form.valid?
      render :edit_profile
    elsif profile_params[:new_profile].present?
      dir = "#{Rails.root}/app/assets/profiles/"
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
      profilename = profile_params[:name]+ "_" + Time.now.strftime('%Y%m%d_%H%M%S') + "." + ActiveStorage::Filename.new(profile_params[:new_profile].original_filename).extension
      File.open(Rails.root.join('app/assets/', 'images', profilename ), 'wb') do |f|
          f.write(profile_params[:new_profile].read)
      end
      @profile_form.profile = profilename
      update_user_profile(@profile_form)
    else
      update_user_profile(@profile_form)
    end
  end

  # function : search user
  # search users by criteria
  # params : name, email, from date, to date
  # return : users
  def search_user
    @users = UserService.searchUser(params)
    render :index
  end

  # function : update_password
  # update password
  # params : id, password, new password
  def update_password
    user = UserService.getUserById(params[:id])
    if !user.authenticate(params[:password])
      redirect_to change_password_user_path, notice: Messages::INCORRECT_PASSWORD
    elsif  params[:new_password] != params[:new_password_confirmation]
      redirect_to change_password_user_path, notice: Messages::INCORRECT_PASSWORD_CONFIRM
    else
      isUpdatedPassword = UserService.updatePassword(user, params)
      if isUpdatedPassword
        redirect_to users_path
      else
        redirect_to change_password_user_path
      end
    end
  end

  # function : destroy
  # delete user
  # params : id
  def destroy
    UserService.deleteUser(params[:id],current_admin[:id])
    redirect_to users_path
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # set user params
  def user_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :role, :phone, :dob, :address, :profile,:create_user_id, :updated_user_id)
  end

  # set user profile params
  def profile_params
    params.require(:profile_form).permit(:id, :name, :email, :role, :phone, :dob, :address, :profile, :new_profile, :updated_user_id)
  end

  # function : update_user_profile
  # update profile
  # params : profile_form
  def update_user_profile(profile_form)
    isUpdateProfile = UserService.updateProfile(profile_form)
    if isUpdateProfile
      redirect_to users_path
    else
      asdasd
      render :edit_profile
    end
  end
end
