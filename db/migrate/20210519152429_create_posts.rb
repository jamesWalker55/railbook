class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.reference :author
      t.text :content

      t.timestamps
    end
  end
end
