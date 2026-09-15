class CommentReaction < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  # ❤️: like, 🖐️: same, ☕️: otsukare
  enum :reaction_type, { like: 0, same: 1, otsukare: 2 }

  validates :user_id, uniqueness: { scope: :comment_id }
  validates :reaction_type, presence: true
end
