class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset
      redirect_to login_path, :notice => Messages::EMAIL_IS_SENT
    else
      redirect_to new_password_reset_path, :notice => Messages::USER_NOT_EXIST
    end

  end
  
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end
  
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :notice => Messages::PASSWORD_RESET_EXPIRED
    elsif params[:user][:password] != params[:user][:password_confirmation]
      redirect_to edit_password_reset_path, :notice => Messages::PASSWORD_RESET_NOT_MATCH
    elsif @user.update_attribute(:password, params[:user][:password])
      redirect_to login_path, :notice => Messages::RESET_PASSWORD
    else
      render :edit
    end
  end
end
