require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "comments" do
    context "belongs to user" do
      it { should belong_to(:user) }
    end

    context "belongs to post" do
      it { should belong_to(:post) }
    end

    context "validate body" do
      it { should validate_presence_of(:body) }
    end

    context "validate author" do
      it { should validate_presence_of(:author) }
    end
  end
end
