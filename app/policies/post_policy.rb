class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  class Scope < Scope
    def resolve
      raise Pundit::NotDefinedError, "Cannot scope NilClass"
    end
  end

  def initialize(user, post)
    @user, @post = user, post
  end

  def create?
    require_user_is_member_or_admin!
  end

  def update?
    require_user_is_admin_or_author!
  end

  def destroy?
    require_user_is_admin_or_author!
  end

  def new?
    require_user_is_member_or_admin!
  end

  def approve_post?
    require_user_is_admin!
  end

  def edit?
    require_user_is_admin_or_author!
  end

  def show?
    if post.member_only
      require_user_is_member_or_admin!
    else
      true
    end
  end

  private 

  def require_user_is_admin_or_author!
    user.admin? || user == post.user
  end

  def require_user_is_admin!
    user.admin?
  end

  def require_user_is_member_or_admin!
    user.admin? || user.member?
  end
end
