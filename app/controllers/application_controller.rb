class ApplicationController < ActionController::Base
    helper_method :current_admin, :current_user, :logged_in?


    def encode_token(payload)
        JWT.encode(payload, 's3cr3t')
    end

    def auth_header
        # { Authorization: 'Bearer <token>' }
        request.headers['Authorization']
    end

    def decoded_token(token)
        # header: { 'Authorization': 'Bearer <token>' }
        begin
        JWT.decode(token, 's3cr3t', true, algorithm: 'HS256')
        rescue JWT::DecodeError
        nil
        end
    end

    def current_user
        if cookies[:user_id]
            # decode = JWT.decode(cookies[:user_id], 'yourSecret', true, algorithm: 'HS256')
            token = decoded_token(cookies[:user_id])
            if !token.present?
              redirect_to login_path, notice: "Authorization is not correct."
            else
              hash = HashWithIndifferentAccess.new(token[0])
              @current_user = UserService.getUserById(hash[:user_id])
            end
        end  
    end

    def current_admin
        if cookies[:admin_id]
            # decode = JWT.decode(cookies[:user_id], 'yourSecret', true, algorithm: 'HS256')
            token = decoded_token(cookies[:admin_id])
            if !token.present?
              redirect_to login_path, notice: "Authorization is not correct."
            else
              hash = HashWithIndifferentAccess.new(token[0])
              @current_admin = UserService.getUserById(hash[:user_id])
            end
        end       
    end

    def logged_in?
        current_user || current_admin
    end
    
    def authorized
        render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
    end
    
end
