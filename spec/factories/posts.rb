FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number:20) }
    association :user
    association :genre

    # materialsとrecipesの関連付け
    transient do
      materials_count { 2 } # デフォルトで2つのmaterialsを生成する例
      recipes_count { 2 }
    end

    after(:build) do |post|
      image_data = Faker::Lorem.characters(number: 10) # ダミーのデータを生成
      post.complete_image.attach(
        io: StringIO.new(image_data),
        filename: 'test_image.jpeg',
        content_type: 'image/jpeg'
      )
    end

    after(:create) do |post, evaluator|
      create_list(:material, evaluator.materials_count, post: post)
      create_list(:recipe, evaluator.recipes_count, post: post)
    end
  end
end
