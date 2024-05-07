class Material < ApplicationRecord
  belongs_to :post
  with_options presence: true do
    validates :name
    validates :amount
  end
end
