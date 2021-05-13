class PostRepository
    class << self

        # function: getAllPost
        # get post list
        # params: 
        # return: @posts
        def getAllPosts
            @posts = Post.where(deleted_user_id: nil)
        end

        # function: getPostById
        # get post by post_id
        # params: id
        # return: @post
        def getPostById(id)
            @post = Post.find(id)
        end

        # function: updatePost
        # Update post
        # params: post, post_params
        # return: isPostUpdate
        def updatePost(post, post_params)
            isPostUpdate = post.update(
                'title' => post_params[:title],
                'description' => post_params[:description],
                'status' => post_params[:status],
                'updated_at' => Time.now,
                'updated_user_id' => post_params[:updated_user_id]
            )
        end
        
        # function: searchPost
        # search post by keyword
        # params: keyword
        # return: posts
        def searchPost(keyword)
            posts = Post.where(deleted_user_id: nil).where("title like ? or description like ?", "%" + keyword + "%", "%" + keyword + "%")
        end

        # function: createPost
        # create post
        # params: post
        # return: isSavePost
        def createPost(post)
            isSavePost = post.save
        end

        # function: deletePost
        # delete post
        # params: post, deleted_user_id
        def deletePost(post, deleted_user_id)
            post.update(
                'deleted_at' => Time.now,
                'deleted_user_id' => deleted_user_id
            )
        end
    end
end
