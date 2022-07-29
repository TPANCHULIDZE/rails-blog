require 'rails_helper'
require_relative '../support/devise'


RSpec.describe PostsController, type: :controller do
  subject(:post1) { create(:post) }
  let(:user_id) { User.last.id }
  
  login_user

  describe "before action methods" do
    it { expect(controller).to use_before_action(:require_user_signed_in!) }
    it { expect(controller).to use_before_action(:set_post) }
    it { expect(controller).to use_before_action(:set_user) }
    it { expect(controller).to use_before_action(:require_authorize_post!) }
    it { expect(controller).to use_before_action(:set_locale) }
  end

  describe "GET /index" do
    before { get :index }
      
    it { should render_template(:index) } 
  end

  describe "GET /show" do
    before { get :show, params: { id: post1.id } }

    it { should render_template(:show) }
  end

  describe "GET /unapprove_post" do
    before { get :unapprove_posts, params: { user_id: user_id } }
      
    it { should render_template(:unapprove_posts) } 
  end

  describe "POST /approve_post" do
    context "user is not admin" do
      before { post :approve_post, params: { id: post1.id, user_id: user_id } }

      it { expect(controller).to set_flash[:alert] }
      it { should redirect_to root_path }
    end

    context "user is admin" do
      login_admin

      before {
        post :approve_post, params: { id: post1.id, user_id: user_id }
      }


      it { should redirect_to post1 }
    end
  end

  describe "GET /user_posts" do
    before { get :user_posts, params: { id:  user_id } }

    it { should render_template(:user_posts) }
  end

  describe "GET /new" do
    before { get :new }

    it { should render_template(:new) }
  end

  describe "POST /create" do
    let(:valid_params) { 
      {
        post: {
          title: "dewds",
          body: "ekdfsnm",
          member_only: false
        }
      }
    }  

    let(:invalid_params) {
      {
        post: {
          title: "",
          body: "jkdmflkjnmfls",
          member_only: false
        }
      }
    } 

    context "valid post" do
      before { post :create, params: valid_params }

      it { should redirect_to post_path(Post.last) }
      it { expect(controller).to set_flash[:notice].to("Post was successfully created.")}
    end

    context "invalid post" do
      before { post :create, params: invalid_params }

      it { should render_template(:new) }
    end
  end

  describe "GET /edit" do
    let(:new_post) { create(:post, user_id: user_id ) }
    before { get :edit, params: { id: new_post.id } }

    it { should render_template(:edit) }
  end

  describe "PATCH /update" do
    let(:new_post) { create(:post, user_id: user_id ) }
    let(:valid_params) { 
      {
        title: "jndnfjen"
      }
    }

    let(:invalid_params) {
      {
        title: nil
      }
    }
    context "valid params" do
      before { patch :update, params: { id: new_post.id, post: valid_params } }

      it { should redirect_to new_post }
      it { expect(controller).to set_flash[:notice].to("Post was successfully updated.")}
    end

    context "invalid params" do
      before { patch :update, params: { id: new_post.id, post: invalid_params } }

      it { should render_template(:edit) }
    end
  end

  describe "DELETE /destroy" do
    let(:new_post) { create(:post, user_id: user_id ) }
    before { delete :destroy, params: { id: new_post.id } }

    it { should redirect_to posts_path }
    it { expect(controller).to set_flash[:notice].to("Post was successfully destroyed.")}
  end
end
