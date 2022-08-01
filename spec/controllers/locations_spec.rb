require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  login_user

   let(:user_id) { User.last.id }

  describe "before action methods" do
    it { expect(controller).to use_before_action(:set_locale) }
    it { expect(controller).to use_before_action(:require_user_signed_in!) }
  end

  describe "GET /new" do
    before { get :new }

    it { should render_template(:new) } 
  end

  describe "POST /create" do
    let(:valid_params) {
      {
        location: {
          street: "Kostava",
          city: "Kutaisi",
          state: "Imereti",
          country: "Georgia"
        }
      }
    }

    let(:invalid_params) {
      {
        location: {
          street: nil,
          city: "Kutaisi",
          state: "Imereti",
          country: "Geor"
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

    context "params permit" do
        let(:params) {
          {
            location: {
              street: "Kostava",
              city: "Kutaisi",
              state: "Imereti",
              country: "Georgia"
            }
          }
        }

        it { 
          should permit(:street, :city, :state, :country).for(:create, params: params).on(:location)
        }
    end
  end

  describe "DELETE /destroy" do
    context "user delete his/her location" do
      let(:location) { create(:location, user_id: user_id) }
      
      before { delete :destroy, params: { id: location.id, user_id: user_id } }

      it { should redirect_to profile_path(user_id) }
    end

    context "admin delete user location" do
      login_admin

      let(:location) { create(:location) }

      before { delete :destroy, params: { id: location.id, user_id: location.user_id } }

      it { should redirect_to profile_path(location.user_id) }
    end
  end
end

