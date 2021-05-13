class PostService
    class << self

        # function: getAllPost
        # get post list
        # params: 
        # return: @posts
        def getAllPosts
            @posts = PostRepository.getAllPosts
        end

        # function: getPostById
        # get post by post_id
        # params: id
        # return: @post        
        def getPostById(id)
            @post = PostRepository.getPostById(id)
        end

        # function: updatePost
        # Update post
        # params: post_params
        # return: isPostUpdate
        def updatePost(post_params)
            @post = getPostById(post_params[:id])
            isPostUpdate = PostRepository.updatePost(@post, post_params)
        end

        # function: searchPost
        # search post by keyword
        # params: keyword
        # return: posts
        def searchPost(keyword)
            posts = PostRepository.searchPost(keyword)
        end

        # function: createPost
        # create post
        # params: post
        # return: isSavePost
        def createPost(post_params)
            post = Post.new(post_params)
            post.status = 1
            isSavePost = PostRepository.createPost(post)
        end

        # function: deletePost
        # delete post
        # params: post, deleted_user_id
        def deletePost(post_id,deleted_user_id)
            post = getPostById(post_id)
            PostRepository.deletePost(post, deleted_user_id)
        end
    end    
end