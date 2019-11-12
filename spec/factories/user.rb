# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    nickname                 { "テスト太郎" }
    sequence(:email)         { |n| " TEST#{n}@example.com" }
    password                 { "0000000" }
    password_confirmation    { "0000000" }
  end
end
