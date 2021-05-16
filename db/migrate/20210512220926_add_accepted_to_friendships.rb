class AddAcceptedToFriendships < ActiveRecord::Migration[6.1]
  def change
    add_column :friendships, :accepted, :boolean
  end
end
