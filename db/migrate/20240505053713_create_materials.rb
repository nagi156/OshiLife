class CreateMaterials < ActiveRecord::Migration[6.1]
  def change
    create_table :materials do |t|
      t.integer :post_id, nill: false
      t.string :name, nill: false
      t.integer :amount, nill: false
      t.timestamps
    end
  end
end
