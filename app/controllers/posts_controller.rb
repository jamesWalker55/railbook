class PostsController < ApplicationController
  before_action :set_personal_post, only: %i[ edit update destroy ]
  before_action :set_visible_post, only: %i[ show ]

  # GET /posts or /posts.json
  def index
    @posts = Post.visible_to_user(current_user).order(updated_at: :desc)
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to root_path, notice: "Post was successfully created."
    else
      redirect_to root_path, notice: "Unable to create post!"
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_personal_post
      # allow access to personal posts only
      @post = current_user.posts.find(params[:id])
    end

    def set_visible_post
      # allow access to personal posts and friends posts
      @post = Post.visible_to_user(current_user).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:content)
    end
end
