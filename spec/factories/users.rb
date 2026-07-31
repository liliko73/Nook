FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { 'password123' }
    password_confirmation { 'password123' }
    username { 'テストユーザー' }
    birthday_year { 1995 }
    birthday_month { 1 }
    birthday_date { 1 }
    gender { :female } # enum指定 (male, female, other)
    self_introduction { 'よろしくお願いします。' }
    confirmed_at { Time.current } # deviseのconfirmable対策
  end
end
