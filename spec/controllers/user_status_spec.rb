require "rails_helper"

RSpec.describe UserStatusController, type: :controller do
  login_admin

  let(:user) { create(:user) }

  describe "before action methods" do
    it { expect(controller).to use_before_action(:set_locale) }
    it { expect(controller).to use_before_action(:require_user_signed_in!) }
    it { expect(controller).to use_before_action(:set_user) }
    it { expect(controller).to use_before_action(:require_authorize_user!) }
  end

  describe "PATCH /user_become_guest" do
    context "guest" do
      before { patch :user_become_guest, params: { id: user.id } }

      it { should redirect_to profile_path(user.id) }

      it {
        expect(User.last.status).to eq("guest")
      }
    end
  end

  describe "PATCH /user_become_member" do
    context "member" do
      before { patch :user_become_member, params: { id: user.id} } 
      
      it { should redirect_to profile_path(user.id) }
      
      it {
        expect(User.last.status).to eq("member")
      }
    end
  end

  describe "PATCH /user_become_admin" do
    context "admin" do
      before { patch :user_become_admin, params: { id: user.id } } 
      
      it { should redirect_to profile_path(user.id) }

      it {
        expect(User.last.status).to eq("admin")
      }
    end
  end
end