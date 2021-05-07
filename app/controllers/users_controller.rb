class UsersController < ApplicationController
  before_action :authorized

  def index
    @users = UserService.listAll
  end

  def new
    @user = User.new()
  end

  def show
    @user = UserService.getUserById(params[:id])
  end

  def create
    @user = User.new(user_params)

    isSaveUser = UserService.createUser(@user)
    respond_to do |format|
      if isSaveUser
        format.html { redirect_to users_path, notice: "User was successfully created." }
        format.json { render :index, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

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

  def profile
    @user = UserService.getUserById(params[:id])
  end

  def edit_profile
    @user = UserService.getUserById(params[:id])
  end

  def update_profile
    @user = User.new(user_params)
    unless @user.valid?
      render :edit_profile
    end
    unless user_params[:profile].nil?
      dir = "#{Rails.root}/app/assets/profiles/"
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
      profilename = user_params[:name]+ "_" + Time.now.strftime('%Y%m%d_%H%M%S') + "." + ActiveStorage::Filename.new(user_params[:profile].original_filename).extension
      File.open(Rails.root.join('app/assets/', 'images', profilename ), 'wb') do |f|
          f.write(user_params[:profile].read)
      end
      @user.profile = profilename
    end
    isUpdateProfile = UserService.updateProfile(@user)
    if isUpdateProfile
      redirect_to users_path
    else
      render :edit_profile
    end
  end

  def search_user
    @users = UserService.searchUser(params)
    render :index
  end

  def update_password
    user = UserService.getUserById(params[:id])
    if !user.authenticate(params[:password])
      redirect_to change_password_user_path, notice: "The Password is incorrect"
    elsif  params[:new_password] != params[:new_password_confirmation]
      redirect_to change_password_user_path, notice: "New password confirmation is not matched"
    else
      isUpdatedPassword = UserService.updatePassword(user, params)
      if isUpdatedPassword
        redirect_to users_path
      else
        redirect_to change_password_user_path
      end
    end
  end

  def destroy
    UserService.deleteUser(params[:id],current_user[:id])
    redirect_to users_path
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :role, :phone, :dob, :address, :profile,:create_user_id, :updated_user_id)
  end
end
