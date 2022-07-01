class ProfileController < ApplicationController
  def profile
    @user = User.find_by(id: params[:id])
  end
end