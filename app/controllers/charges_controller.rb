class ChargesController < ApplicationController
  before_action :require_user_signed_in!

  def new
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
    
    @user = User.find_by(email: params[:stripeEmail])
    @user.update(status: 1)

    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charges_path
  end
end
