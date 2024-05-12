class Recipe < ApplicationRecord
  belongs_to :post
  validates :instructions, presence: true, length: { minimum: 1 }

  has_one_attached :recipe_image

  # 作り方の画像の有無
  def get_recipe_image
    if recipe_image.attached?
      image_convert_for_recipe_image(recipe_image)
    else
      'no_image_square.jpg'
    end
  end
  # 画像のリサイズ
  def image_convert_for_recipe_image(image)
     recipe_image.variant(resize: "300").processed
  end
end
