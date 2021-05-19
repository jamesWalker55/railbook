class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def verify_post_visibility
    # check that post_id is visible to current user
    Post.visible_to_user(current_user).find(comment_params[:post_id])
  end
end
