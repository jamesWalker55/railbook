class AddLikeRelationsCountToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :like_relations_count, :integer
  end
end
