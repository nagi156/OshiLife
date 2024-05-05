class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :post_id, nill: false
      t.text :instructions, nill: false
      t.timestamps
    end
  end
end
