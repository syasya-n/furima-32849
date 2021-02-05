FactoryBot.define do
  factory :item do
    name                   { Faker::Lorem.sentence }
    description            { Faker::Internet.free_email }
    category_id            { 2 }
    condition_id           { 2 }
    shipping_fee_person_id { 2 }
    ship_from_region_id    { 2 }
    delivery_day_id        { 2 }
    price                  { 1000 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/arrow_top.png'), filename: 'arrow_top.png')
    end
  end
end
