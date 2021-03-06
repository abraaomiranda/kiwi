class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :content
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
    add_index :posts, :created_at
  end
end
