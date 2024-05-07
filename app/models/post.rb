class Post < ApplicationRecord
  belongs_to :user
  
  has_many :materials, dependent: :destroy
  accepts_nested_attributes_for :materials, reject_if: :all_blank, allow_destroy: true
  
  has_many :recipes, dependent: :destroy
  accepts_nested_attributes_for :recipes, reject_if: :all_blank, allow_destroy: true
  
  has_one_attached :post_image
  # 投稿画像の有無
  def get_post_image
    (post_image.attached?)? post_image : 'no_image_square.jpg'
  end
  # 画像のリサイズ
  def image_convert_for_post_image
    image.variant( resize: "208" ).processed
  end
end
