class Ability
  include CanCan::Ability

  def initialize(user)
    return guest_abilities if user.nil?

    @user = user

    user_abilities
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
end
