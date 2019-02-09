class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.super_admin?
      can :manage, :all
    else
      can :manage, [Group, Category, Transaction]
    end
  end
end
