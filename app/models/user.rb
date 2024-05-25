class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { in: 1..50 }
  validates :registration_check, acceptance: true, on: :create

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :entries, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :rooms, through: :entries

  has_many :relationships, foreign_key: :following_id
  has_many :followings, through: :relationships, source: :followed #フォローしている一覧を表示するためのもの

  has_many :reverse_relationships, class_name: 'Relationship', foreign_key: :followed_id
  has_many :followeds, through: :reverse_relationships, source: :following

  has_one_attached :profile_image
  # プロフィール画像の有無&リサイズ
  def get_profile_image
    if profile_image.attached?
      image_convert_for_profile_image(profile_image)
    else
      'no_image_square.jpg'
    end
  end
  # 画像のリサイズ
  def image_convert_for_profile_image(image)
    profile_image.variant( resize: "208" ).processed
  end

  # 有効ユーザーのみログインできるメソッド
  def active_for_authentication?
    super && (is_active == true)
  end
  # ゲストユーザーに関するメソッド
  GUEST_USER_EMAIL = "guest@example.com"
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト(閲覧専用)"
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end

  # 検索機能のメソッド
  def self.search_for(search, word)
    User.where("name LIKE ?", "%#{word}%")
  end
  # いいねを探す
  def favorite_by?(post)
    self.favorites.exists?(post_id: post.id)
  end

  # フォローしているか探すメソッド
  def followed_by?(user)
     followings.include?(user)
  end
end

