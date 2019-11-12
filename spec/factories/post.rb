# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title     { "おすすめです！" }
    body      { Faker::Lorem.sentence }
    img       { File.open("#{Rails.root}/spec/factories/images/test.jpeg") }
    user

    after(:build) do |post|
      post.categories = []
      post.restaurant = FactoryBot.build(:restaurant, post: post)
      post.categories << FactoryBot.build(:category, name: "もも")
    end
  end
end
