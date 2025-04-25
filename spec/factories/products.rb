FactoryBot.define do
  factory :product do
    name { 'test' }
    description { 'text' }
    category_id { 2 }
    condition_id { 2 }
    shipping_cost_id { 2 }
    prefecture_id { 2 }
    shipping_date_id { 2 }
    price { 500 }
    association :user
    after(:build) do |message|
      message.image.attach(io: File.open('public/images/テスト画像.png'), filename: 'test_image.png')
    end
  end
end
