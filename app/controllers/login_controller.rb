class LoginController < ApplicationController
  def login
  end

  def userlogin
    @user = UserService.find_by_email(params[:email])
    if params[:email].blank? && params[:password].blank?
      redirect_to login_path, notice: "Email and Password are required"
    elsif params[:email].blank? && params[:password]!=nil
      redirect_to login_path, notice: "Email is required"
    elsif params[:email]!=nil && params[:password].blank?
      redirect_to login_path, notice: "Password is required"
    elsif @user && @user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:user_id] = @user.id
      else
        cookies[:user_id] = @user.id
      end
      redirect_to users_path, notice: "Logged in!"
    else      
      redirect_to login_path, notice: "Email or password is invalid"
    end
  end
   
end
