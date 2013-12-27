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
        can :by_school,School,:school=>{:id=>Qx.find(user.qx_id).schools.map { |s| s.id  }}
        can :manage,School,:id=>Qx.find(user.qx_id).schools.map { |s| s.id  }
        can :manage,Report,:school=>{:id=>Qx.find(user.qx_id).schools.map { |s| s.id  }}
        can :read,Topic
    elsif user.is_school?
        can :read,Exam
        can [:read,:create,:update,:confirm],OrderItem,:school=>{:id=>user.school_id}
        cannot :index,OrderItem
        can [:by_school,:read,:create,:update,:confirm],ScoreFile,:school=>{:id=>user.school_id}
        cannot :index,ScoreFile
        can [:read,:create,:destroy,:confirm],Report,:school=>{:id=>user.school_id}
        can :read,Topic
        # can :show_by_shcool,School,:id=>user.school_id
    elsif user.is_jyy?
        can :read,Exam
        can [:read],Report
    else
        cannot :manage, :all
    end
  end
end
