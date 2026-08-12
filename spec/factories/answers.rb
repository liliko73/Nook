FactoryBot.define do
  factory :answer do
    user { nil }
    question { nil }
    parent_id { 1 }
    body { "MyText" }
  end
end
