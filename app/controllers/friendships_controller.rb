class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[ show edit update destroy ]

  # POST /friendships or /friendships.json
  def create
    # @friendship = Friendship.new(friendship_params)
    @friendship = current_user.friendships.build(friend_id: friendship_params[:friend_id], accepted: false)

    if @friendship.save
      redirect_to current_user, notice: "Friend request send."
    else
      redirect_to current_user, error: "Unable to send friend request."
    end
  end

  def update
    @friendship.accepted = true

    if @friendship.save
      redirect_to current_user, notice: "Friend request accepted."
    else
      redirect_to current_user, error: "Unable to accept friend request."
    end
  end

  # DELETE /friendships/1 or /friendships/1.json
  def destroy
    @friendship.destroy
    redirect_to current_user, notice: "Friend removed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = current_user.friendships.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friendship_params
      params.require(:friendship).permit(:friend_id, :create, :destroy)
    end
end
