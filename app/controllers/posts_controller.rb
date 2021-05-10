class PostsController < ApplicationController
    before_action :authorized

    def index
        @posts = PostService.getAllPosts
    end

    def edit
        @post = PostService.getPostById(params[:id])
    end

    def update_confirm
        @post = Post.new(post_params)
        unless @post.valid?
            render edit_post_path
        end
    end

    def update_post
        isPostupdate = PostService.updatePost(post_params)
        if isPostUpdate
            redirect_to posts_path
        else 
            render :edit
        end
    end

    private

    # post parameters
    def post_params
      params.require(:post).permit(:id, :title, :description, :status, :create_user_id, :updated_user_id)
    end
end
