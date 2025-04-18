FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { 'test@example' }
    password              { 'a000000' }
    password_confirmation { password }
    first_name            { 'Taro' }
    last_name             { 'Yamada' }
    first_name_kana       { 'タロウ' }
    last_name_kana        { 'ヤマダ' }
    birthday              { '1990-01-01' }
  end
end
