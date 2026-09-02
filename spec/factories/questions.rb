FactoryBot.define do
  factory :question do
    association :user
    title { "離乳食について" }
    body { "おすすめの離乳食の進め方を教えてください。" }
  end
end
