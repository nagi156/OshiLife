class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:name]
  validates :name, presence: true, length: { in: 1..50 }

  has_many :posts, dependent: :destroy

  has_one_attached :profile_image
  # プロフィール画像の有無
  def get_profile_image
    (profile_image.attached?)? profile_image : 'no_image_square.jpg'
  end
  # 画像のリサイズ
  def image_convert_for_profile_image
    image.variant( resize: "208" ).processed
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
end