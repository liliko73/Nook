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

    # User作成時にお子様（children）を最低1人自動生成する設定
    after(:build) do |user|
      user.children << build(:child, user: user) if user.children.empty?
    end
  end
end
