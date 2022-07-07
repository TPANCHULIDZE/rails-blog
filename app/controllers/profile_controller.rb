class ProfileController < ApplicationController
  before_action :require_user_signed_in!
  decorates_assigned :user


  def profile
    @user = User.find_by(id: params[:id])
    @mobiles = @user.mobiles.first(3)
  end
end