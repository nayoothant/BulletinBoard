class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

    def current_user
        @current_user ||= UserService.getUserById(cookies[:user_id]) if cookies[:user_id].present?
    end

    def logged_in?
        !!current_user
    end
    
    def authorized
        redirect_to login_path unless logged_in?
    end
end
