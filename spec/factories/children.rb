FactoryBot.define do
  factory :child do
    birthday_year { 2020 }
    birthday_month { 5 }
    birthday_date { 10 }
    gender { :female }
    association :user
  end
end
