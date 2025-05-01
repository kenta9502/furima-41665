FactoryBot.define do
  factory :address do
    post_code                          { '123-4567' }
    prefecture_id                      { 1 }
    municipality                       { '渋谷区' }
    street_address                     { '道玄坂1-2-3' }
    building_name                      { '渋谷ハイツ101' } # Can be nil if optional
    phone_number                       { '09012345678' }
    association :purchase
  end
end
