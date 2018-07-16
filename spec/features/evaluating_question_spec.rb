require 'rails_helper'

RSpec.feature "Evaluating Questions" do

	before do
	 	@john = FactoryBot.create(:admin_user)
	 	login_as(@john, :scope => :user)
	 	FactoryBot.create(:question)
	 	QuestionStatus.create!(name: "Approved")
	end


	scenario "A user evaluates a question correctly" do
		visit questions_path
		click_link "Evaluate"
		select('Approved', :from => 'revision_history_question_status_id')

		click_button "Create Revision history"
		expect(page).to have_content("Question was successfully reviewed")
	end


end