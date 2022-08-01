require 'rails_helper'

RSpec.describe MobilesController, type: :controller do
  login_user

  let(:user_id) { User.last.id }

  describe "before action" do
    it { expect(controller).to use_before_action(:require_user_signed_in!) }
    it { expect(controller).to use_before_action(:set_locale) }
  end

  describe "GET /new" do
    before { get :new }

    it { should render_template(:new) }
  end

  describe "POST /create" do
    let(:valid_params) {
      {
        mobile: {
          number: "574400420",
          country: "GE"
        }
      }
    }

    let(:invalid_params) {
      {
        mobile: {
          number: "574400420",
          country: "US"
        }
      }
    }

    context "input valid params" do
      before { post :create, params: valid_params }

      it { should redirect_to profile_path(user_id) }
    end

    context "input invalid params" do
      before { post :create, params: invalid_params }

      it { should render_template(:new) }
    end

    context "check permit params" do
      it {
        should permit(:number, :country).for(:create, params: valid_params).on(:mobile)
      }
    end
  end

  describe "DELETE /destroy" do
    context "user delete his/her mobile" do
      let(:mobile) { create(:mobile, user_id: user_id)}
      
      before { delete :destroy, params: { id: mobile.id, user_id: user_id } }

      it { should redirect_to profile_path(user_id) }
    end

    context "admin delete user mobile" do
      login_admin 
      
      let(:mobile) { create(:mobile) }

      before { delete :destroy, params: { id: mobile.id, user_id: mobile.user_id } }

      it { should redirect_to profile_path(mobile.user_id) }
    end
  end
end