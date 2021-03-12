FactoryBot.define do
  factory :order_destination do
    postal_code { "123-4567" }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    municipality { "渋谷区" }
    address { "1丁目" }
    building { "東京ハイツ" }
    phone_number { Faker::Number.leading_zero_number(digits: 11) }
  end
end
