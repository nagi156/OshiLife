FactoryBot.define do
  factory :material do
    name { Faker::Lorem.characters(number:10) }  # ランダムな材料名を生成
    amount { %w[1 5 10 20].sample }  # ランダムに選択
    association :post
  end
end