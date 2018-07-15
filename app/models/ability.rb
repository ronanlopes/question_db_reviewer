class Ability
  include CanCan::Ability

  def initialize(user)

    if user.admin?
        can :manage, :all
        cannot [:new,:create], Question
    elsif user.client?
        can [:new,:create], Question
        can :manage, :questions, user_id: user.id
    end

  end
end
