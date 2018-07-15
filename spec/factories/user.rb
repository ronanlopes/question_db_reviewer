require 'factory_bot'

FactoryBot.define do
  factory :user do
    name "John"
    email "johndoe@example.com"
    password "password"
    password_confirmation "password"
  end
end 