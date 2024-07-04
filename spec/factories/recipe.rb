FactoryBot.define do
  factory :recipe do
    instructions { Faker::Lorem.characters(number:20) }
    association :post

    after(:build) do |recipe|
      recipe_image_data = Faker::Lorem.characters(number: 10)
      recipe.recipe_image.attach(
        io: StringIO.new(recipe_image_data),
        filename: 'test_image.jpeg',
        content_type: 'image/jpeg'
      )
    end
  end
end
