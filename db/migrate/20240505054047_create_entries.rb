class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.integer :user_id, nill: false
      t.integer :room_id, nill: false
      t.timestamps
    end
  end
end
