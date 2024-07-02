FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number:20) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :guest_user, class: 'User' do
    name { "ゲスト(閲覧専用)" }
    email { 'guest@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end