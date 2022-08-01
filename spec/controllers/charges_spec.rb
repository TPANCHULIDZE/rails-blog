require 'rails_helper'

RSpec.describe ChargesController, type: :controller do
  login_user

  describe "before action methods" do
    it { expect(controller).to use_before_action(:require_user_signed_in!) }
    it { expect(controller).to use_before_action(:set_locale) }
  end

  describe "GET /new" do
    context "pay by stripe" do
      before { get :new }

      it { should render_template(:new) }
    end
  end
end
