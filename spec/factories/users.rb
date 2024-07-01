FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :guest_user, class: 'User' do
    email { 'guest@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end