class AddAnsweredToInquiries < ActiveRecord::Migration[6.1]
  def change
    add_column :inquiries, :answered, :boolean, default: false, null: false
  end
end
