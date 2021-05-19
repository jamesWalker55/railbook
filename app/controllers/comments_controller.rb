class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :verify_post_visibility, only: %i[ create ]

  def create
    comment = current_user.comments.build(comment_params)

    if comment.save
      redirect_to request.referrer, notice: "Commented on post."
    else
      redirect_to request.referrer, alert: "Unable to comment on post."
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

    def comment_params
      params.require(:comment).permit(:content, :post_id)
    end
end
