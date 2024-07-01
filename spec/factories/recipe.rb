FactoryBot.define do
  factory :recipe do
    instructions { Faker::Lorem.characters(number:20) }
    association :post
  end
end
