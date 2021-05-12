class PostService
    class << self
        
        def getAllPosts
            @posts = PostRepository.getAllPosts
        end

        def getPostById(id)
            @post = PostRepository.getPostById(id)
        end

        def updatePost(post_params)
            @post = getPostById(post_params[:id])
            isPostUpdate = PostRepository.updatePost(@post, post_params)
        end

        def searchPost(keyword)
            posts = PostRepository.searchPost(keyword)
        end

        def createPost(post_params)
            post = Post.new(post_params)
            post.status = 1
            isSavePost = PostRepository.createPost(post)
        end

        def deletePost(post_id,deleted_user_id)
            post = getPostById(post_id)
            PostRepository.deletePost(post, deleted_user_id)
        end
    end    
end