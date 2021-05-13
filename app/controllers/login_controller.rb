class LoginController < ApplicationController

  # Show login page
  def login
    cookies.delete(:user_id)
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
      if params[:remember_me]
        cookies.permanent[:user_id] = @user.id
      else
        cookies[:user_id] = @user.id
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
    # go to login page
    redirect_to login_path
  end
   
end
