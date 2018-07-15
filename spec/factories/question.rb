FactoryBot.define do

	factory :question_status do
		name "Pending"
	end

  factory :choice do
    sequence(:content) { |n| "choice #{n}" }
    question
  end


  factory :question do
    sequence(:content) { |n| "question #{n}" }
    source "BBC"
    year "1999"
    user
    question_status

     before :create do |question|
      create_list :choice, 5, question: question
    end

  end

end 