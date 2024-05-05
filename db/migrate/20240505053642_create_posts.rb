class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, nill: false
      t.string :title, nill: false
      t.timestamps
    end
  end
end
