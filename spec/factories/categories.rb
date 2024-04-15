# spec/factories/categories.rb

FactoryBot.define do
    factory :category do
      name { Faker::Lorem.word } # Generate a random word for the category name
    end
  end
  