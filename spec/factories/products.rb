FactoryBot.define do
    factory :category do
      name { Faker::Commerce.department }
    end
  end

  # spec/factories/products.rb
  FactoryBot.define do
    factory :product do
      name { Faker::Commerce.product_name }
      price { Faker::Commerce.price(range: 100.0..1000.0) }
      association :category
    end
  end