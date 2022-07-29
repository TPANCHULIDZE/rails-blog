require 'rails_helper'
require_relative '../support/devise'
require 'faker'

RSpec.describe CommentsController, type: :controller do
  login_user

  let(:user_id) { User.last.id }
  let(:author) { User.last.username }

   describe "before action methods" do
    it { expect(controller).to use_before_action(:require_user_signed_in!) }
    it { expect(controller).to use_before_action(:set_post) }
    it { expect(controller).to use_before_action(:set_comment) }
    it { expect(controller).to use_before_action(:set_locale) }
  end

  describe "POST /create" do
    let(:mypost) { create(:post, user_id: user_id) }
    let(:valid_params) { 
      {
        body: Faker::Alphanumeric.alpha(number: 20),
        author: author
      }
    }

    let(:invalid_params) { 
      {
        body: nil,
        author: author
      }
    }
    context "input valid params" do
      before { post :create, params: { post_id: mypost.id, comment: valid_params } }

      it { should redirect_to mypost }
      it { expect(controller).to set_flash[:notice].to("create new comment") }
    end

    context "input invalid params" do
      before { post :create, params: { post_id: mypost.id, comment: invalid_params } }

      it { should redirect_to mypost }
      it { expect(controller).to set_flash[:alert].to("comment can't be empty") }
    end

    context "params permit" do
      let(:params) {
        {
          comment: {
            body: Faker::Alphanumeric.alpha(number: 20),
            author: author
          },
          post_id: mypost.id,
        }
      }

      it { 
        should permit(:author, :body).for(:create, params: params).on(:comment)
      }
    end
  end

  describe "DELETE /destroy" do
    let(:mycomment) { create(:comment, user_id: user_id, author: author) }

    context "delete comment" do
      before { delete :destroy, params: { post_id: mycomment.post.id, id: mycomment.id } }

      it { should redirect_to mycomment.post }
      it { expect(controller).to set_flash[:notice].to("comment was deleted") }
      it { expect(response).to have_http_status(303) }
    end
  end

  describe "PATCH /update" do
    let(:mypost) { create(:post, user_id: user_id) }
    let(:mycomment) { create(:comment, user_id: user_id, author: author) }

    let(:valid_params) { 
      {
        body: Faker::Alphanumeric.alpha(number: 20),
        author: author
      }
    }

    let(:invalid_params) { 
      {
        body: nil,
        author: author
      }
    }
    context "input valid params" do
      before { patch :update, params: { post_id: mypost.id, id: mycomment.id, comment: valid_params } }

      it { should redirect_to mypost }
      it { expect(controller).to set_flash[:notice].to("update comment") }
    end

    context "input invalid params" do
      before { patch :update, params: { post_id: mypost.id, id: mycomment.id, comment: invalid_params } }

      it { should redirect_to mypost }
      it { expect(controller).to set_flash[:alert].to("comment not update") }
    end

    context "params permit" do
      let(:update_params) {
        {
          comment: {
            body: Faker::Alphanumeric.alpha(number: 20),
            author: author
          },
          post_id: mypost.id,
          id: mycomment.id
        }
      }

      it { 
        should permit(:author, :body).for(:update, params: update_params).on(:comment)
      }
    end
  end
end