FactoryBot.define do
  factory :user do
    name "John"
    sequence(:email) { |n| "john#{n}@example.com" }
    password "password"
    password_confirmation "password"
  end
end 