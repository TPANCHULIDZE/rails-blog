require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "post" do
    context "belongs to user" do
      it { should belong_to(:user) }
    end

    context 'has many comments' do
      it { should have_many(:comments).dependent(:destroy) }
    end

    context 'has many likes' do
      it { should have_many(:likes).dependent(:destroy) }
    end

    context 'validate title' do
      it { should validate_presence_of(:title) }
    end

    context 'validate body' do
      it { should validate_presence_of(:body) }
    end
  end
end
