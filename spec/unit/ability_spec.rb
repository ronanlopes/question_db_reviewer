require 'cancan'
require 'cancan/matchers'
require_relative '../../app/models/ability.rb'

describe "User" do
  describe "abilities" do
    subject(:ability){ Ability.new(user) }
    let(:user){ nil }


    context "when is an administrator" do
      let(:user){ FactoryBot.create(:admin_user) }

      it{ should_not be_able_to(:create, Question) }
      it{ should be_able_to(:create, RevisionHistory) }
      it{ should be_able_to(:create, User) }
      it{ should be_able_to(:create, Role) }
      it{ should be_able_to(:create, QuestionStatus) }

    end

    context "when is a client" do
      let(:user){ FactoryBot.create(:client_user) }

      it{ should be_able_to(:create, Question) }
      it{ should_not be_able_to(:create, RevisionHistory) }
      it{ should_not be_able_to(:create, User) }
      it{ should_not be_able_to(:create, Role) }
      it{ should_not be_able_to(:create, QuestionStatus) }

    end
  end
end