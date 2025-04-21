FactoryBot.define do
  factory :product do
    name { "MyString" }
    price { 1 }
    description { "MyText" }
    category { "MyString" }
    stock { 1 }
  end
end
