class ApplicationController < ActionController::Base
    def current_ability
        @current_ability ||= Ability.new(current_user)
    end
    
    # Delegate `can?` method to the `current_ability`
    def can?(action, subject)
        current_ability.can?(action, subject)
    end
    helper_method :can?
end
  