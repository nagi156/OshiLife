class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { in: 1..50 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

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

  GUEST_USER_EMAIL = "guest@example.com"
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストさん"
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end

  # 検索機能のメソッド
  def self.search_for(search, word)
    User.where("name LIKE ?", "%#{word}%")
  end

end

