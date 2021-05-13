class UserRepository
    class << self

        # function: getAllUserList
        # get user list
        # params: 
        # return: @users
        def getAllUserList
            @users = User.where(deleted_user_id: nil)
        end

        # function: new
        # new user
        # params: user_params
        # return: @user
        def new(user_params)
            @user = User.new(user_params)
        end
        
        # function: getUserById
        # get user by user id
        # params: id
        # return: @user
        def getUserById(id)
            @user = User.find(id)
        end

        # function: createUser
        # create new user
        # params: user
        # return: isSaveUser
        def createUser(user)
            isSaveUser = user.save
        end

        # function: find_by_email
        # find user by email
        # params: user
        # return: isSaveUser
        def find_by_email(email)
            @user = User.find_by(email: email, deleted_user_id: nil)
        end

        # function: updateProfile
        # update user profile
        # params: user, user_params
        # return: isupdatedProfile
        def updateProfile(user, user_params)
            isupdatedProfile = user.update(
                'name' => user_params.name,
                'email' => user_params.email,
                'phone' => user_params.phone,
                'role' => user_params.role,
                'dob' => user_params.dob,
                'address' => user_params.address,
                'profile' => user_params.profile,
                'updated_user_id' => user_params.updated_user_id,
            )
        end

        # function: searchUser
        # search user by criteria
        # params: name, email, from_date, to_date
        # return: users
        def searchUser(name, email, from_date, to_date)
            if from_date.present? and to_date.present?
                users = User.where(deleted_user_id: nil).where("name like ? and email like ? and created_at >= ? and created_at <= ?", "%" + name + "%", "%" + email + "%", from_date, Date.parse(to_date)+1)
            elsif from_date.present?
                users = User.where(deleted_user_id: nil).where("name like ? and email like ? and created_at >= ?", "%" + name + "%", "%" + email + "%", from_date)
            elsif to_date.present?
                users = User.where(deleted_user_id: nil).where("name like ? and email like ? and created_at <= ?", "%" + name + "%", "%" + email + "%", Date.parse(to_date)+1)
            else
                users = User.where(deleted_user_id: nil).where("name like ? and email like ?", "%" + name + "%", "%" + email + "%")
            end
        end

        # function: updatePassword
        # update password
        # params: user, params
        # return: isUpdatedPassword
        def updatePassword(user, params)
            isUpdatedPassword = user.update(
                'password' => params[:new_password],
                'updated_user_id' => params[:id]
            )
        end

        # function: deleteUser
        # delete user
        # params: user, deleted_user_id
        def deleteUser(user, deleted_user_id)
            user.update(
                'deleted_at' => Time.now,
                'deleted_user_id' => deleted_user_id
            )
        end
    end
end