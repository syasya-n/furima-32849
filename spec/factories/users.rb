FactoryBot.define do
  factory :user do
    id                    {10}
    nickname              { Faker::Name }
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name_kanji               { '性' }
    first_name_kanji              { '名' }
    last_name_kana { 'セイ' }
    first_name_kana { 'メイ' }
    birth_date { Faker::Date.backward }
  end
end
