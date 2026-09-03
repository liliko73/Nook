class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  # 自己参照の関連付けを追加
  belongs_to :parent, class_name: "Answer", optional: true
  has_many :replies, class_name: "Answer", foreign_key: "parent_id", dependent: :destroy

  validates :body, presence: true, length: { maximum: 1000 }
end
