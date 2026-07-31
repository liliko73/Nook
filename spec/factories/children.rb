FactoryBot.define do
  factory :child do
    association :user
    birthday_year { 2023 }
    birthday_month { 10 }
    birthday_date { 1 }
    gender { 1 }
  end
end
