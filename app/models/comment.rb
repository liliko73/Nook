class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :theme

  # 親コメントとの関連（parent_id を参照。親が無い場合もあるため optional: true）
  belongs_to :parent, class_name: "Comment", optional: true

  # 子コメント（返信）との関連（parent_id が自分の id を指しているコメント群）
  has_many :replies, class_name: "Comment", foreign_key: "parent_id", dependent: :destroy

  # リアクションとの関連付け
  has_many :comment_reactions, dependent: :destroy

  validates :body, presence: true, length: { maximum: 1000 }

  # ミュートしているユーザーのコンテンツを非表示にするスコープ
  scope :without_muted_users, ->(user) {
  where.not(user_id: user.muting_user_ids) if user.present? && user.muting_users.any?
  }
end
