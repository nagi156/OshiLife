class Inquiry < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :title
    validates :message
    validates :response
  end

  scope :answered, -> { where(answered: true).order(created_at: :desc) }
  scope :unanswered, -> { where(answered: false).order(created_at: :desc) }


end
