class Post < ApplicationRecord
  belongs_to :user

  has_many :materials, dependent: :destroy
  accepts_nested_attributes_for :materials, reject_if: :all_blank, allow_destroy: true

  has_many :recipes, dependent: :destroy
  accepts_nested_attributes_for :recipes, reject_if: :all_blank, allow_destroy: true

  has_one_attached :complete_image

  validates :title, presence: true, length: { in: 1..30 }

  # 投稿画像の有無とリサイズ
  def get_complete_image
    if complete_image.attached?
      image_convert_for_complete_image(complete_image)
    else
      'no_image_square.jpg'
    end
  end
  # 画像のリサイズ
  def image_convert_for_complete_image(image)
     complete_image.variant(resize: "300").processed
  end
end
