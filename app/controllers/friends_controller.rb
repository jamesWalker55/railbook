class FriendsController < ApplicationController
  before_action :validate_friend_request, only: %i[create]

  # POST /friendships or /friendships.json
  def create
    # send friend request
    @friendship = current_user.friendships.build(friend_id: friendship_params[:friend_id], accepted: false)

    if @friendship.save
      redirect_to request.referrer, notice: 'Friend request sent.'
    else
      redirect_to request.referrer, alert: 'Unable to send friend request.'
    end
  end

  def update
    # accept friend request
    @friendship = current_user.received_friendships.where(user_id: friendship_params[:friend_id]).first
    @friendship.accepted = true

    if @friendship.save
      redirect_to request.referrer, notice: 'Friend request accepted.'
    else
      redirect_to request.referrer, alert: 'Unable to accept friend request.'
    end
  end

  # DELETE /friendships/1 or /friendships/1.json
  def destroy
    # refuse friend request / remove friend
    @friendship = current_user.get_friendship friendship_params[:friend_id]
    @friendship.destroy
    if @friendship.accepted
      redirect_to request.referrer, notice: 'Friend removed.'
    else
      redirect_to request.referrer, notice: 'Friend request removed.'
    end
  end

  private

  def validate_friend_request
    redirect_to root_path, alert: "Cannot send friend request to yourself!" and return if current_user.id == friendship_params[:friend_id].to_i
    redirect_to root_path, alert: "Friend request already exists!" and return unless current_user.has_friendship.where(id: friendship_params[:friend_id]).empty?
  end

  # Only allow a list of trusted parameters through.
  def friendship_params
    params.permit(:friend_id)
  end
end
