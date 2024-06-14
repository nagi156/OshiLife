class Recipe < ApplicationRecord
  belongs_to :post
  validates :instructions, presence: true
  validate :check_image_extension

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

  private

  def check_image_extension
    if recipe_image.attached?
      acceptable_types = ["image/jpeg", "image/png"]
      acceptable_extensions = [".jpeg", ".jpg", ".png"]

      unless acceptable_types.include?(recipe_image.blob.content_type)
        errors.add(:recipe_image, 'はjpegまたはpng形式の画像のみアップロードできます')
      end

      unless acceptable_extensions.include?(File.extname(recipe_image.blob.filename.to_s).downcase)
        errors.add(:recipe_image, 'はjpegまたはpng形式の画像のみアップロードできます')
      end
    end
  end
end
