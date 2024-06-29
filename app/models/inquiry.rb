class Inquiry < ApplicationRecord
  belongs_to :user

  validates :message, presence: true

  scope :answered, -> { where(answred: true).order(created_at: :desc) }
  scope :unanswered, -> { where(answred: false).order(created_at: :desc) }


end
