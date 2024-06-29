class AddResponseToInquiries < ActiveRecord::Migration[6.1]
  def change
    add_column :inquiries, :response, :text
  end
end
