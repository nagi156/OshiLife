class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.timestamps
    end

    add_index :favorites, [:user_id, :post_id], unique: true
    add_foreign_key :favorites, :users
    add_foreign_key :favorites, :posts
  end
end
