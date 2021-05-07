class ApplicationController < ActionController::Base
    helper_method :current_user

    private

    def current_user
        @current_user ||= UserService.getUserById(cookies[:user_id]) if cookies[:user_id]
    end
end
