require 'rails_helper'

RSpec.describe ProfileController, type: :controller do
  login_user

  let(:id) { User.last.id }

  describe "before action" do
    it { expect(controller).to use_before_action(:require_user_signed_in!) }
    it { expect(controller).to use_before_action(:set_locale) }
  end

  describe "GET /profile" do
    before { get :profile, params: { id: id } }

    it { should render_template(:profile) } 
  end
end