class LoginController < ApplicationController

  # Show login page
  def login
    cookies.delete(:user_id)
    cookies.delete(:admin_id)
  end

  # function : userlogin
  # params : email, password
  def userlogin

    #find user by email
    @user = UserService.find_by_email(params[:email])

    #check validation for email and password
    if params[:email].blank? && params[:password].blank?
      redirect_to login_path, notice: Messages::EMAIL_AND_PASSWORD_REQUIRE_VALIDATION
    elsif params[:email].blank? && params[:password]!=nil
      redirect_to login_path, notice: Messages::EMAIL_REQUIRE_VALIDATION
    elsif params[:email]!=nil && params[:password].blank?
      redirect_to login_path, notice: Messages::PASSWORD_REQUIRE_VALIDATION
    elsif @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      if params[:remember_me]
        if @user.role == '0'
          cookies.permanent[:admin_id] = @user.id
        elsif @user.role == '1'
          cookies.permanent[:user_id] = @user.id
        end
      else
        if @user.role == '0'
          cookies[:admin_id] = { :value => token, :expires => Time.now + 3600 }
        elsif @user.role == '1'
          cookies[:user_id] = { :value => token, :expires => Time.now + 3600 }
        end
      end
      # go to user list
      redirect_to users_path, notice: Messages::SUCCESSFUL_LOG_IN
    else
      # go to login page   
      redirect_to login_path, notice: Messages::INVALID_EMAIL_OR_PASSWORD
    end
  end

  #function : logout
  def logout
    cookies.delete(:user_id)
    cookies.delete(:admin_id)
    # go to login page
    redirect_to login_path
  end

  # function : sign_up
  # show sign up form page
  # return : @user
  def sign_up
    cookies.delete(:user_id)
    cookies.delete(:admin_id)
    @user = User.new
  end

  # function : create_account
  # create user account
  # params : user_params
  def create_account
    @user = User.new(user_params)
    if @user.valid? && user_params.has_key?(:profile)
      dir = "#{Rails.root}/app/assets/profiles"
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
      profileName = user_params[:name] + "_" + Time.now.strftime('%Y%m%d_%H%M%S') +"." + ActiveStorage::Filename.new(user_params[:profile].original_filename).extension
      File.open(Rails.root.join('app/assets/', 'images', profileName), 'wb') do |f|
        f.write(user_params[:profile].read)
      end
      @user.profile = profileName
    end
    if !@user.valid?
      render :sign_up
    elsif UserService.createUser(@user)
      @login_user = UserService.find_by_email(@user.email)
      cookies[:user_id] = @login_user.id
      redirect_to users_path, notice: Messages::SUCCESSFUL_SIGN_UP
    else
      render :sign_up
    end
  end
   
  private

    # User params
    def user_params
      params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :role, :phone, :dob, :profile, :create_user_id, :updated_user_id)
    end
end
