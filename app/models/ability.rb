class Ability
  include CanCan::Ability

  def initialize(user)

       user ||= User.new # guest user (not logged in)

          if user.has_role? :admin
            can :manage, :all
	          can :update, User
		  can :assign_admin_role, User
		  can :remove_admin_role, User
		  cannot :destroy, User do |u|
		    ( u.has_role?(:admin) )
		  end
            cannot :create, User
	    cannot [:create, :destroy], Setting
	    can :edit, Setting
          else
            if user.has_role? :user
              can :manage, Quiz 
	      can :read, Animal
	      
	      cannot [:read, :manage], Setting
              cannot :read, User
              cannot :destroy, :all
              cannot :edit, :all
              cannot :create, :all
            end
          end
  end
end
