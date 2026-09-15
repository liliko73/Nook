class Child < ApplicationRecord
  belongs_to :user

  # 性別のenum
  enum :gender, { male: 0, female: 1, other: 2 }

  # バリデーションの設定
  validates :birthday_year, presence: true, numericality: { greater_than_or_equal_to: 1900, less_than_or_equal_to: ->(_child) { Time.zone.now.year } }
  validates :birthday_month, presence: true
  validates :birthday_date, presence: true
  validates :gender, presence: true
end
