require "rails_helper"

RSpec.feature "Signup users" do

	scenario "with valid credentials" do
		visit "/"
	end

	scenario "with invalid credentials" do
		visit "/"
		click_link "Sign up"
		fill_in "Name", with: ""
		fill_in "Email", with: ""
		fill_in "Password", with: ""
		fill_in "Password confirmation", with: ""
		click_button "Sign up"

		expect(page).to have_content("Name can't be blank")
		expect(page).to have_content("Email can't be blank")
		expect(page).to have_content("Password can't be blank")

	end


end