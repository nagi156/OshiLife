class Recipe < ApplicationRecord
  belongs_to :post
  validates :instructions, presence: true, length: { minimum: 1 }
end
