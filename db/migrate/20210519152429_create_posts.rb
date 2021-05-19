class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :content

      t.timestamps
    end
    add_reference :posts, :user, foreign_key: true
  end
end
