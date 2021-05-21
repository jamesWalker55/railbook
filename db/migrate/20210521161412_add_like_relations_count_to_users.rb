class AddLikeRelationsCountToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :like_relations_count, :integer
  end
end
