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
    end    
end