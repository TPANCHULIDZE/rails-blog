class UserStatusController < ApplicationController
  before_action :require_user_signed_in! 
  before_action :set_user
  before_action :require_authorize_user!

  def user_become_guest
    @user.update(status: 0)
    redirect_to profile_path(@user)
  end

  def user_become_member
    @user.update(status: 1)
    redirect_to profile_path(@user)
  end

  def user_become_admin
    @user.update(status: 2)
    redirect_to profile_path(@user)
  end

  private

  def set_user 
    @user = User.find_by(id: params[:id])
  end

  def require_authorize_user!
    authorize current_user
  end
end

