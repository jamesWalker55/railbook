class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[ show edit update destroy ]

  # POST /friendships or /friendships.json
  def create
    @friendship = current_user.friendships.build(friend_id: friendship_params[:friend_id], accepted: false)

    # user can't send request to himself
    if friendship_params[:friend_id].to_i == current_user.id
      redirect_to request.referrer, alert: "Can't send friend request to yourself!"
    elsif @friendship.save
      redirect_to request.referrer, notice: "Friend request sent."
    else
      redirect_to request.referrer, alert: "Unable to send friend request."
    end
  end

  def update
    @friendship.accepted = true

    if @friendship.save
      redirect_to request.referrer, notice: "Friend request accepted."
    else
      redirect_to request.referrer, alert: "Unable to accept friend request."
    end
  end

  # DELETE /friendships/1 or /friendships/1.json
  def destroy
    @friendship.destroy
    redirect_to request.referrer, notice: "Friend removed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = current_user.friendships.or(current_user.inverse_friendships).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friendship_params
      params.require(:friendship).permit(:friend_id)
    end
end
