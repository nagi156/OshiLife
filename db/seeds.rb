# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: "admin@example.com",
  password: "admina"
  )

genres = [
  { name: '痛バッグ' },
  { name: 'うちわ' }
]

genres.each do |genre|
  Genre.find_or_create_by!(genre)
end

ita_bag_genre = Genre.find_by(name: '痛バッグ')
uchiwa_genre = Genre.find_by(name: 'うちわ')


olivia = User.find_or_create_by!(email: "olivia1@example.com") do |user|
  user.name = "Olivia"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.png"), filename:"sample-user1.png")
  user.introduction = "推しのライブに向けてうちわ量産中！よろしくお願いします！"
end

james = User.find_or_create_by!(email: "james2@example.com") do |user|
  user.name = "James"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.png"), filename:"sample-user2.png")
  user.introduction = "痛バッグやうちわ、ぬいなど大体何でも作ります。100％ではありませんがフォロバします～"
end


Post.find_or_create_by!(title: "応援うちわの作り方") do |post|
  post.complete_image.attach(io: File.open("#{Rails.root}/db/fixtures/sample_post4.png"), filename: "sample_post4.png")

  material1 = Material.create(name: "ジャンボうちわ黒", amount: 1)
  material2 = Material.create(name: "カラーシールLサイズ(ピンク）", amount: 1)

  recipe_instruction1 = Recipe.create(instructions: "うちわを用意し型紙(バック)をカットし型紙をシールに貼ります。")
  recipe_instruction1.recipe_image.attach(io: File.open("#{Rails.root}/db/fixtures/sample_post5.png"), filename: "sample_post5.png")

  recipe_instruction2 = Recipe.create(instructions: "バックに文字を貼り残りの台紙をゆっくりと剥がしながら、空気が入らないように全体を貼っていきます。")
  recipe_instruction2.recipe_image.attach(io: File.open("#{Rails.root}/db/fixtures/sample_post6.png"), filename: "sample_post6.png")


  post.recipes << [recipe_instruction1, recipe_instruction2]
  post.materials << [material1, material2]
  post.genre = uchiwa_genre
  post.save

  post.user = olivia
end


Post.find_or_create_by!(title: "かわいい痛バッグの作り方") do |post|
  post.complete_image.attach(io: File.open("#{Rails.root}/db/fixtures/sample_post1.png"), filename: "sample_post1.png")

  material1 = Material.create(name: "缶バッジ", amount: 10)
  material2 = Material.create(name: "痛バッグ用のバッグ", amount: 1)

  recipe_instruction1 = Recipe.create(instructions: "好きなキャラクターの缶バッジを用意します。")
  recipe_instruction1.recipe_image.attach(io: File.open("#{Rails.root}/db/fixtures/sample_post2.png"), filename: "sample_post2.png")

  recipe_instruction2 = Recipe.create(instructions: "バッグのサイズに合わせて付ければ完成です。")
  recipe_instruction2.recipe_image.attach(io: File.open("#{Rails.root}/db/fixtures/sample_post3.png"), filename: "sample_post3.png")

  post.recipes << [recipe_instruction1, recipe_instruction2]
  post.materials << [material1, material2]
  post.genre = ita_bag_genre
  post.save

  post.user = james
end