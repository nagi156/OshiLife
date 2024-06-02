class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notifications

  validates :message, presence: true, length: { maximum: 150 }

  private

  def create_notifications
     # self.user_id は、このチャットを作成したユーザーのIDです。
    self.room.entries.where.not(user_id: self.user_id).each do |user|
      # ここで各ユーザーに対して通知を作成します。
      Notification.create!(
        user_id: user.user_id,  # 通知を受けるユーザー
        subject: self,  # 関連するチャット
        action_type: :chated_me
      )
    end
  end
end
