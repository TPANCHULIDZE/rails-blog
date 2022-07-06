class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotDefinedError, "Cannot scope NilClass"
    end
  end

  def user_become_guest?
    require_user_is_admin!
  end

  def user_become_member?
    require_user_is_admin!
  end

  def user_become_admin?
    require_user_is_admin!
  end

  private 

  def require_user_is_admin!
    user.admin?
  end
end
