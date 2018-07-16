require 'rails_helper'

RSpec.feature "Creating Questions" do

	before do
		FactoryBot.create(:question_status)
	 	@john = FactoryBot.create(:client_user)
	 	login_as(@john, :scope => :user)
		visit questions_path
		click_link "New Question"
	end


	scenario "A user creates a valid question" do

		fill_in "Content", with: "Some example content for a question"
		fill_in "Source", with: "BBC"
		fill_in "Year", with: "2014"
		fill_in "question_choices_attributes_0_content", with: "A choice"
		fill_in "question_choices_attributes_1_content", with: "B choice"
		fill_in "question_choices_attributes_2_content", with: "C choice"
		fill_in "question_choices_attributes_3_content", with: "D choice"
		fill_in "question_choices_attributes_4_content", with: "E choice"
		find(:css, "#question_choices_attributes_0_correct").set(true)

		click_button "Create Question"

		expect(page).to have_content "Question was successfully created"
	end


	scenario "A user submit a empty question" do

		click_button "Create Question"

		expect(page).to have_content "Content can't be blank"
		expect(page).to have_content "Source can't be blank"
		expect(page).to have_content "Year can't be blank"
		expect(page).to have_content "Choices content can't be blank"
		expect(page).to have_content "should have at least 1 correct answer"

	end

end