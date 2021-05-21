class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :set_visible_post, only: %i[ create ]

  def create
    comment = current_user.comments.build(post: @post, content: comment_params[:content])

    if comment.save
      redirect_to request.referrer, notice: "Commented on post."
    else
      redirect_to request.referrer, alert: "Unable to comment: " + comment.errors.full_messages.join("; ")
    end
  end

  def destroy
    @comment.destroy
    redirect_to request.referrer, notice: "Comment deleted."
  end

  private 
    def set_comment
      @comment = current_user.comments.find(params[:id])
    end

    def set_visible_post
      # allow access to personal posts and friends posts
      @post = Post.visible_to_user(current_user).find(comment_params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:content, :post_id)
    end
end
