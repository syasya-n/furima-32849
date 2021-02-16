FactoryBot.define do
  factory :order_information do
    post_code          { '123-4567' }
    region_id          { '3' }
    city               { '青梅市' }
    address            { '1-3' }
    building           { '東京ビルディング' }
    phone_number       { '09012345678' }
    token              {"tok_6ed29f1e1210f085cee796f560a1"}
  end
end
