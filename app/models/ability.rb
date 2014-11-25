class Ability
  include CanCan::Ability

  def initialize(user)
    return guest_abilities if user.nil?

    @user = user

    if user.admin?
      admin_abilities
    else
      user_abilities
    end
  end

  def guest_abilities
    can :read, Product
  end

  def user_abilities
    guest_abilities

    can :create, Order
    can :add_to_cart, Product
    can :remove_from_cart, Product
    can :cart, User
  end

  def admin_abilities
    can :manage, :all
  end
end
