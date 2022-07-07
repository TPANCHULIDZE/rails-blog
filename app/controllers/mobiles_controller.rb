class MobilesController < ApplicationController

  def new
    @mobile = Mobile.new()
  end

  def create
    if valid_mobile?
      current_user.mobiles.create(mobile_params)
      redirect_to profile_path(current_user)
    else
      render :new
    end
  end

  def destroy
    @mobile = Mobile.find_by(id: params[:id])
    @mobile.destroy
    redirect_to profile_path(current_user)
  end

  private

  def mobile_params
    params.require(:mobile).permit(:number, :country)
  end

  def valid_mobile?
    phone_object = TelephoneNumber.parse(params[:mobile][:number], params[:mobile][:country])
    phone_object.valid?
  end

end
