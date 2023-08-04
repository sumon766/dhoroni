# ability.rb

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for guest users (not logged in)
    if user.nil?
      cannot :manage, :all
      can :show, Post
      can :index, Post
    end

    # Define abilities for logged-in users
    if user.present?
      # Abilities for all users
      can :show, Post
      can :index, Post

      # Abilities for the post author
      can :new, Post, author_id: user.id
      can :create, Post, author_id: user.id
      can :destroy, Post, author_id: user.id

      # Abilities for comments
      can :create, Comment, author_id: user.id
      can :destroy, Comment, author_id: user.id

      # Abilities for admin users
      if user.role == 'admin'
        can :destroy, Post
        can :destroy, Comment
      end
    end
  end
end
