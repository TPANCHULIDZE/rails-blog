class ChargesController < ApplicationController
  def new
    @user = User.find_by(id: params[:user_id])
  end

  def create
    @amount = 500

    customer = Stripe::Customer.create(
    :email => params[:stripeEmail],
    :source => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
    :customer => customer.id,
    :amount => @amount,
    :description => 'Rails Stripe customer',
    :currency => "usd"
    )
    
    @user = User.find_by(id: params[:user_id])
    @user.update(status: 1)

    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end


end
