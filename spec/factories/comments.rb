FactoryBot.define do
  factory :comment do
    user { nil }
    theme { nil }
    parent_id { 1 }
    body { "MyText" }
  end
end
