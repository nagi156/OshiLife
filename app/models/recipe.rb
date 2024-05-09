class Recipe < ApplicationRecord
  belongs_to :post
  validates :instructions, presence: true, length: { minimum: 1 }

  has_one_attached :recipe_image

  # 作り方の画像の有無
  def get_recipe_image
    (recipe_image.attached?)? recipe_image : 'no_image_square.jpg'
  end
  # 画像のリサイズ
  def image_convert_for_recipe_image
    image.variant( resize: "200" ).processed
  end
end
