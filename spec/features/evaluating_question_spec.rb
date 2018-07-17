require 'rails_helper'

RSpec.feature "Evaluating Questions" do

	before do
	 	@john = FactoryBot.create(:admin_user)
	 	login_as(@john, :scope => :user)
	 	@question = FactoryBot.create(:question)
	 	QuestionStatus.create!(name: "Approved")
	 	QuestionStatus.create!(name: "Denied")
	end


	scenario "A user evaluates a question correctly" do
		visit question_evaluate_question_path(@question)
		select('Approved', :from => 'revision_history_question_status_id')

		click_button "Create"
		expect(page).to have_content("Question was successfully reviewed")
	end


	scenario "A user denies a question but doesn't leave a comment" do
		visit question_evaluate_question_path(@question)
		select('Denied', :from => 'revision_history_question_status_id')

		click_button "Create"
		expect(page).to have_content("is required when you reject the question")
	end


end