FactoryBot.define do
  factory :purchase_address do
    post_code                          { '123-4567' }
    prefecture_id                      { 2 }
    municipality                       { '渋谷区' }
    street_address                     { '道玄坂1-2-3' }
    building_name                      { '渋谷ハイツ101' }
    phone_number                       { '09012345678' }
    token                              { 'tok_abcdefg1234567890' }
  end
end
