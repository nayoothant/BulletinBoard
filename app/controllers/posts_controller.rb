class PostsController < ApplicationController
    before_action :authorized

    def index
        @posts = PostService.getAllPosts
    end

    def new
        @post = Post.new()
    end

    def edit
        @post = PostService.getPostById(params[:id])
        @post_form = PostForm.new(PostForm.initialize(@post))
    end

    def update_confirm
        @post_form = PostForm.new(post_form_params)
        unless @post_form.valid?
            render :edit
        end
    end

    def update_post
        isPostUpdate = PostService.updatePost(post_form_params)
        if isPostUpdate
            redirect_to posts_path
        else 
            render :edit
        end
    end

    def search_post
        @keyword=params[:keyword]
        @posts = PostService.searchPost(@keyword)
        render :index
    end

    def post_create_confirm
        @post = Post.new(post_params)
        unless @post.valid?
            render :new
        end
    end

    def create
        isSavePost = PostService.createPost(post_params)
        if isSavePost
          redirect_to posts_path
        else
          render :new
        end
    end

    def destroy
        PostService.deletePost(params[:id],current_user[:id])
        redirect_to posts_path
    end

    private

    # post parameters
    def post_params
      params.require(:post).permit(:id, :title, :description, :status, :create_user_id, :updated_user_id)
    end

    def post_form_params
        params.require(:post_form).permit(:id, :title, :description, :status, :updated_user_id)
    end
end
