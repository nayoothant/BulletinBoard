class UserService
    class << self
        def listAll
            @users = UserRepository.listAll
        end

        def new(user_params)
            @user = UserRepository.new(user_params)
        end

        def createUser(user)
            user.role = user.role == "Admin" ? 0 : 1
            isSaveUser = UserRepository.createUser(user)
        end

        def getUserById(id)
            @user = UserRepository.getUserById(id)
        end

        def find_by_email(email)
            @user = UserRepository.find_by_email(email)
        end

        def updateProfile(user_params)
            user = getUserById(user_params[:id])
            user_params.profile = user.profile unless user_params.profile.present?
            isUpdateProfile = UserRepository.updateProfile(user, user_params)
        end

        def searchUser(params)
            @name = params[:name]
            @email = params[:email]
            @from_date = params[:from_date]
            @to_date = params[:to_date]
            @users = UserRepository.searchUser(@name, @email, @from_date, @to_date)
        end

        def updatePassword(user, params)
            isUpdatedPassword = UserRepository.updatePassword(user, params)
        end

        def deleteUser(user_id,deleted_user_id)
            user = getUserById(user_id)
            UserRepository.deleteUser(user, deleted_user_id)
        end
    end
end
