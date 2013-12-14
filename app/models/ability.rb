class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
    user ||= User.new # guest user (not logged in)
    if user.blank? 
        # not logged in
        cannot :manage, :all
    elsif user.is_s_admin?
         can :manage, :all
    elsif user.is_qx_admin?
        can :read,Exam
        can :manage,OrderItem,:school=>{:id=>Qx.find(user.qx_id).schools.map { |s| s.id  }}  
        can [:read,:update],User,:school_id=>Qx.find(user.qx_id).schools.map { |s| s.id  }
        can :manage,ScoreFile,:school=>{:id=>Qx.find(user.qx_id).schools.map { |s| s.id  }}
        can :by_school,ScoreFile,:school=>{:id=>Qx.find(user.qx_id).schools.map { |s| s.id  }}
        can :manage,School,:id=>Qx.find(user.qx_id).schools.map { |s| s.id  }
    elsif user.is_school?
        can :read,Exam
        can [:read,:create,:update,:confirm],OrderItem,:school=>{:id=>user.school_id}
        cannot :index,OrderItem
    else
        cannot :manage, :all
    end
  end
end
