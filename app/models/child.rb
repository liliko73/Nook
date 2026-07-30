class Child < ApplicationRecord
  belongs_to :user

  # 性別のenum
  enum :gender, { male: 0, female: 1, other: 2 }

  # バリデーションの設定
  validates :birthday_year, presence: true
  validates :birthday_month, presence: true
  validates :birthday_date, presence: true
  validates :gender, presence: true
end
