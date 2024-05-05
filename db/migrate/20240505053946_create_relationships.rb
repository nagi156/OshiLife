class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :following_id, nill: false
      t.integer :followed_id, nill: false
      t.timestamps
    end
  end
end
