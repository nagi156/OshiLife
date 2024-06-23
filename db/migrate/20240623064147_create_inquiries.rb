class CreateInquiries < ActiveRecord::Migration[6.1]
  def change
    create_table :inquiries do |t|
      t.references :user, foreign_key: true
      t.string :title, null: false
      t.text :message, null: false

      t.timestamps
    end
  end
end
