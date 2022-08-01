require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  login_user

  let(:user_id) { User.last.id }
  let(:mypost) { create(:post) }

  describe "before actions" do
    it { expect(controller).to use_before_action(:set_locale) }
    it { expect(controller).to use_before_action(:require_user_signed_in!) }
    it { expect(controller).to use_before_action(:set_post) }
    it { expect(controller).to use_before_action(:set_like) }
  end

  describe "POST /create" do
    before { post :create, params: { post_id: mypost.id } }

    it { should redirect_to mypost }
  end

  describe "DELETE /destroy" do
    let(:like) { create(:like, user_id: user_id, post_id: mypost.id ) }
    before { delete :destroy, params: { post_id: mypost.id, id: like.id } }

    it { should redirect_to mypost }
    it { expect(response).to have_http_status(303)}
  end
end