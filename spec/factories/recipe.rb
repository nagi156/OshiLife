FactoryBot.define do
  factory :recipe do
    instructions { Faker::Lorem.characters(number:20) }
    association :post
    
  end
  factory :recipe_image do
    image_file { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test2.jpg'), 'image/jpeg') }
  end
end
