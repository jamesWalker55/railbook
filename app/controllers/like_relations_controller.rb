class LikeRelationsController < ApplicationController
  before_action :set_visible_post, only: %i[ create ]

  def create
    like = current_user.like_relations.build(post: @post)

    if like.save
      redirect_to request.referrer, notice: "Liked post."
    else
      redirect_to request.referrer, alert: "Unable to like post."
    end
  end

  def destroy
    like = current_user.like_relations.find(params[:id])
    like.destroy
    redirect_to request.referrer, notice: "Unliked post."
  end

  private
    # Only allow a list of trusted parameters through.
    def like_relation_params
      params.require(:like_relation).permit(:post_id)
    end

    def set_visible_post
      # allow access to personal posts and friends posts
      @post = Post.visible_to_user(current_user).find(like_relation_params[:post_id])
    end
end
