FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { 'password123' }
    password_confirmation { 'password123' }
    username { 'テストユーザー' }
    self_introduction { '子育て奮闘中です！' }
    birthday_year { 1990 }
    birthday_month { 5 }
    birthday_date { 15 }
    gender { 1 }
    prefecture { '東京都' }
  end
end
