class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :read, :all
      can :index, :home
      can :stats, :home
      can :create, Assignment
      can :destroy, Assignment, user_id: user.id, garde: {state: "active", period: {state: "open"}}
      if user.admin?
        can :manage, :all
        cannot :destroy, User, id: user.id
      end
    end
    # Define abilities for the passed in (current) user. For example:
    #
    #   if user
    #     can :access, :all
    #   else
    #     can :access, :home
    #     can :create, [:users, :sessions]
    #   end
    #
    # Here if there is a user he will be able to perform any action on any controller.
    # If someone is not logged in he can only access the home, users, and sessions controllers.
    #
    # The first argument to `can` is the action the user can perform. The second argument
    # is the controller name they can perform that action on. You can pass :access and :all
    # to represent any action and controller respectively. Passing an array to either of
    # these will grant permission on each item in the array.
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
