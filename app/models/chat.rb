class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_one :notification, as: :subject, dependent: :destroy

  validates :message, presence: true, length: { maximum: 150 }


  include NotificationConcern

  after_create :create_notifications

  def create_notifications
    self.room.entries.where.not(user_id: self.user_id).each do |entry|
      create_notification(entry.user, self, :chated_me)
    end
  end
end
