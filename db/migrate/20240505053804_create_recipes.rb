class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :post_id, null: false
      t.text :instructions, null: false
      t.timestamps
    end
  end
end
