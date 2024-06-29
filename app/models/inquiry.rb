class Inquiry < ApplicationRecord
  belongs_to :user

  validates :message, presence: true

  scope :answered, -> { where(answered: true).order(created_at: :desc) }
  scope :unanswered, -> { where(answered: false).order(created_at: :desc) }


end
