require 'rails_helper'

RSpec.describe Like, type: :model do
  describe "like" do
    context "belongs to user" do
      it { should belong_to(:user) }
    end

    context "belongs to post" do
      it { should belong_to(:post) }
    end
  end
end
