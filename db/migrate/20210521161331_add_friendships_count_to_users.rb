class AddFriendshipsCountToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :friendships_count, :integer
  end
end
