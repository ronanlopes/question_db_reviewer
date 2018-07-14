require 'rails_helper'

RSpec.describe "questions/edit", :type => :view do
  before(:each) do
    @question = assign(:question, Question.create!(
      :content => "MyText",
      :source => "MyString",
      :year => 1,
      :question_status => nil,
      :user => nil
    ))
  end

  it "renders the edit question form" do
    render

    assert_select "form[action=?][method=?]", question_path(@question), "post" do

      assert_select "textarea#question_content[name=?]", "question[content]"

      assert_select "input#question_source[name=?]", "question[source]"

      assert_select "input#question_year[name=?]", "question[year]"

      assert_select "input#question_question_status_id[name=?]", "question[question_status_id]"

      assert_select "input#question_user_id[name=?]", "question[user_id]"
    end
  end
end
