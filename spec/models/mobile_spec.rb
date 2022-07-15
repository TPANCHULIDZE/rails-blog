require 'rails_helper'

RSpec.describe Mobile, type: :model do
  describe 'mobiles' do
    context "belongs to user" do
      it { should belong_to(:user) }
    end
  end
end
