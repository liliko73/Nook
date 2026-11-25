class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :answer_reactions, dependent: :destroy

  # 自己参照の関連付けを追加
  belongs_to :parent, class_name: "Answer", optional: true
  has_many :replies, class_name: "Answer", foreign_key: "parent_id", dependent: :destroy

  validates :body, presence: true, length: { maximum: 1000 }

  # ミュートしているユーザーのコンテンツを非表示にするスコープ
  scope :without_muted_users, ->(user) {
  where.not(user_id: user.muting_user_ids) if user.present? && user.muting_users.any?
  }
end
