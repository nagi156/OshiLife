class Recipe < ApplicationRecord
  belongs_to :post
  validates :instructions, presence: true
  has_one_attached :recipe_image
end
