class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :materials, inverse_of: :post
  accepts_nested_attributes_for :materials, allow_destroy: true

  has_many :recipes, inverse_of: :post
  accepts_nested_attributes_for :recipes, allow_destroy: true

  has_one_attached :complete_image

  has_one :notification, as: :subject, dependent: :destroy

  validates :title, presence: true, length: { in: 1..30 }
  # 拡張子の制限メソッド
  validate :check_image_extension

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

  # 検索機能のメソッド
  def self.search_for(search, word)
    Post.where("title LIKE ?", "%#{word}%")
  end

  def favorites_count
    favorites.count
  end

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :most_favorites, -> { left_joins(:favorites).group("posts.id").order("COUNT(favorites.id) DESC") }
  scope :following, -> (following_ids) { where(user_id: following_ids).order(created_at: :desc) }

  
  private

  def check_image_extension
    if complete_image.attached?
      acceptable_types = ["image/jpeg", "image/png"]
      acceptable_extensions = [".jpeg", ".jpg", ".png"]

      unless acceptable_types.include?(complete_image.blob.content_type)
        errors.add(:complete_image, 'はjpegまたはpng形式の画像のみアップロードできます')
      end

      unless acceptable_extensions.include?(File.extname(complete_image.blob.filename.to_s).downcase)
        errors.add(:complete_image, 'はjpegまたはpng形式の画像のみアップロードできます')
      end
    end
  end

end
