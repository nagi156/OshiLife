class Inquiry < ApplicationRecord
  belongs_to :user
# エンドユーザーのバリデーション
  validates :title, :message, presence: true
# 管理者のみ適用のバリデーション
  with_options if: :admin_context? do
    validates :response, presence: true
  end

  # スコープ
  scope :answered, -> { where(answered: true).order(created_at: :desc) }
  scope :unanswered, -> { where(answered: false).order(created_at: :desc) }

  private
# バリデーションのコンテキストがadminの
  def admin_context?
    validation_context == :admin
  end
end
