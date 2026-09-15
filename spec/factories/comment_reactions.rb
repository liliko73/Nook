FactoryBot.define do
  factory :comment_reaction do
    user { nil }
    comment { nil }
    reaction_type { 1 }
  end
end
