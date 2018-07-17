require 'rails_helper'

RSpec.feature "Users signin" do

	before do
		@john = User.create!(name: "John", email: "john@example.com", password: "password", role: Role.find_or_create_by(name: "Administrator"))
	end

	scenario "with valid credentials" do

		visit "/"

		fill_in "Email", with: @john.email
		fill_in "Password", with: @john.password
		click_button "Sign in"

		expect(page).to have_content("Signed in successfully")
		expect(page).to have_content("Welcome, #{@john.name}")
		expect(page).not_to have_link("Sign up")
		expect(page).to have_link("Sign out")

	end


	scenario "with blank credentials" do

		visit "/"

		fill_in "Email", with: ""
		fill_in "Password", with: ""
		click_button "Sign in"

		expect(page).to have_content("Invalid Email or password")
		expect(page).to have_link("Sign up")
		expect(page).not_to have_link("Sign out")

	end



	scenario "with invalid credentials" do

		visit "/"

		fill_in "Email", with: "invalid@email.com"
		fill_in "Password", with: "invalidpassword"
		click_button "Sign in"

		expect(page).to have_content("Invalid Email or password")
		expect(page).to have_link("Sign up")
		expect(page).not_to have_link("Sign out")

	end


end