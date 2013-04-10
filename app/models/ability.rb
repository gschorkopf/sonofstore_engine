class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.user_role.role == :store_admin
      can :manage, :all #Store #no idea...
    # elsif user.platform_admin?
    #   can :manage, :all
    elsif user.user_role.role == :stocker
      can :create, :all #Store #no idea...
      can :edit, :all #Store #no idea...
      can :update, :all #Store #no idea...
    else
      can :read, :all
    end
  end
end
