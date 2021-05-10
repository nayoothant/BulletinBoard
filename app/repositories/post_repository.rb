class PostRepository
    class << self
        def getAllPosts
            @posts = Post.where(deleted_user_id: nil)
        end

        def getPostById(id)
            @post = Post.find(id)
        end

        def updatePost(post, post_params)
            isPostUpdate = post.update(
                'title' => post_params[:title],
                'description' => post_params[:description],
                'status' => post_params[:status],
                'updated_at' => Time.now,
                'updated_user_id' => post_params[:updated_user_id]
            )
        end
    end
end