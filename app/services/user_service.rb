class UserService
    class << self

        # function: getAllUserList
        # get user list
        # params: 
        # return: @users
        def getAllUserList
            @users = UserRepository.getAllUserList
        end

        # function: new
        # new user
        # params: user_params
        # return: @user
        def new(user_params)
            @user = UserRepository.new(user_params)
        end

        # function: createUser
        # create new user
        # params: user
        # return: isSaveUser
        def createUser(user)
            user.role = user.role == "Admin" ? 0 : 1
            isSaveUser = UserRepository.createUser(user)
        end

        # function: getUserById
        # get user by user id
        # params: id
        # return: @user
        def getUserById(id)
            @user = UserRepository.getUserById(id)
        end

        # function: find_by_email
        # find user by email
        # params: user
        # return: isSaveUser
        def find_by_email(email)
            @user = UserRepository.find_by_email(email)
        end

        # function: updateProfile
        # update user profile
        # params: user, user_params
        # return: isupdatedProfile
        def updateProfile(profile_params)
            user = getUserById(profile_params.id)
            isUpdateProfile = UserRepository.updateProfile(user, profile_params)
        end

        # function: searchUser
        # search user by criteria
        # params: name, email, from_date, to_date
        # return: users
        def searchUser(params)
            @name = params[:name]
            @email = params[:email]
            @from_date = params[:from_date]
            @to_date = params[:to_date]
            @users = UserRepository.searchUser(@name, @email, @from_date, @to_date)
        end

        # function: updatePassword
        # update password
        # params: user, params
        # return: isUpdatedPassword
        def updatePassword(user, params)
            isUpdatedPassword = UserRepository.updatePassword(user, params)
        end

        # function: deleteUser
        # delete user
        # params: user, deleted_user_id
        def deleteUser(user_id,deleted_user_id)
            user = getUserById(user_id)
            UserRepository.deleteUser(user, deleted_user_id)
        end
    end
end
