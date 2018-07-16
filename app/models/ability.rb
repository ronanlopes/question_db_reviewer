class Ability
  include CanCan::Ability

  def initialize(user)

    if user.admin?
        can :manage, :all
        cannot [:create, :update], Question
    elsif user.client?
        can [:new,:create, :read], Question
        can [:edit, :update], Question, {user_id: user.id, question_status_id: QuestionStatus.find_by(name: "Denied").try(:id)}
    end

  end
end
