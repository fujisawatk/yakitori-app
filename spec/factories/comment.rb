FactoryBot.define do
  factory :comment do
    comment { "ありがとう" }
    user
    post
  end
end
