class PostsController < ApplicationController
    before_action :authorized

    # function : index
    # show post list
    # return : @posts
    def index
        @posts = PostService.getAllPosts
    end

    # function : new
    # show new post create page
    # return : @post
    def new
        @post = Post.new()
    end

    # function : show
    # show post detail
    # params : post_id
    # return : @post
    def show
        @post = PostService.getPostById(params[:id])    
    end

    # function : edit
    # show edit post page
    # params : id
    # return : @post_form
    def edit
        @post = PostService.getPostById(params[:id])
        @post_form = PostForm.new(PostForm.initialize(@post))
    end

    # function : update_fonfirm
    # confirm post update
    # params : post_form_params
    # return @post_form
    def update_confirm
        @post_form = PostForm.new(post_form_params)
        unless @post_form.valid?
            render :edit
        end
    end

    # function : update_post
    # update post
    # params : post_form_params
    def update_post
        isPostUpdate = PostService.updatePost(post_form_params)
        if isPostUpdate
            redirect_to posts_path
        else 
            render :edit
        end
    end

    # function : search post
    # search posts by keyword
    # params : keyword
    # return : @posts
    def search_post
        @keyword=params[:keyword]
        @posts = PostService.searchPost(@keyword)
        render :index
    end

    # function : post_create_confirm
    # confirm post create
    # params : post_params
    # return : @post
    def post_create_confirm
        @post = Post.new(post_params)
        unless @post.valid?
            render :new
        end
    end

    # function : create
    # Create post
    # params : post_param
    def create
        isSavePost = PostService.createPost(post_params)
        if isSavePost
          redirect_to posts_path
        else
          render :new
        end
    end

    # function : destroy
    # delete post
    # params : post id
    def destroy
        if current_admin.present?            
            PostService.deletePost(params[:id],current_admin[:id])
        else            
            PostService.deletePost(params[:id],current_user[:id])
        end
        redirect_to posts_path
    end

    # function : import_csv
    # upload post csv file
    # params : file
    def import_csv
        if current_admin.present? 
            updated_user_id = current_admin.id
            create_user_id = current_admin.id
        else
            updated_user_id = current_user.id
            create_user_id = current_user.id
        end
        if (params[:file].nil?)
            redirect_to upload_csv_posts_path, notice: Messages::REQUIRE_FILE_VALIDATION        
        elsif !File.extname(params[:file]).eql?(".csv")
            redirect_to upload_csv_posts_path, notice: Messages::WRONG_FILE_TYPE  
        else
            error_msg = PostsHelper.check_header(Constants::HEADER,params[:file])
            if error_msg.present?
                redirect_to upload_csv_posts_path, notice: error_msg
            else 
                Post.import(params[:file],create_user_id,updated_user_id)
                redirect_to posts_path, notice: Messages::UPLOAD_SUCCESSFUL
            end
        end
    end

    # function : download
    # down post list
    # return : Post List.csv
    def download
        @posts = PostService.getAllPosts
        respond_to do |format|
            format.html
            format.csv { send_data @posts.to_csv,  :filename => "Post List.csv" }
          end
    end

    private

    # set post parameters
    def post_params
      params.require(:post).permit(:id, :title, :description, :status, :create_user_id, :updated_user_id)
    end

    # set post form parameters
    def post_form_params
        params.require(:post_form).permit(:id, :title, :description, :status, :updated_user_id)
    end
end
