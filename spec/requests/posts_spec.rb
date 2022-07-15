require 'rails_helper'

RSpec.describe PostsController, type: :request do
    let(:author) { FactoryBot.create(:user) }
    let(:valid_attributes) {
        { :title => "first", :body => "new post",  user_id: author.id }
    }

    let(:valid_session) { {} }
   describe "GET #index" do
      it "returns a success response" do
        expect(author.username).to eq("member")
      end
    end
end
