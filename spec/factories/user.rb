FactoryBot.define do

	factory :admin_role, class: "Role" do
		name "Administrator"
	end

	factory :client_role, class: "Role" do
		name "Client"
	end


  factory :admin_user, class: "User" do
    name "John"
    sequence(:email) { |n| "john#{n}@example.com" }
    password "password"
    password_confirmation "password"
    association :role, factory: :admin_role
  end

  factory :client_user, class: "User" do
    name "John"
    sequence(:email) { |n| "john#{n}@example.com" }
    password "password"
    password_confirmation "password"
    association :role, factory: :client_role
  end

end 