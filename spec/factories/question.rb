FactoryBot.define do

	factory :question_status do

    transient do
      name "Pending"
    end

    before :create do |question_status, options|
      question_status.name = options.name if options.name
    end
	end

  factory :choice do
    sequence(:content) { |n| "choice #{n}" }
    correct "true"
    question
  end


  factory :question do
    sequence(:content) { |n| "question #{n}" }
    source "BBC"
    year "1999"
    association :user, factory: :client_user
    association :question_status, factory: :question_status

    before :create do |question|
      create_list :choice, 5, question: question
    end

  end

end