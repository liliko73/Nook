class Child < ApplicationRecord
  belongs_to :user

  # 性別のenum
  enum :gender, { male: 0, female: 1, other: 2 }
end
