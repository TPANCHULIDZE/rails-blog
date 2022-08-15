require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'Locations' do
    subject(:location) { FactoryBot.build(:location) }

    context 'belongs to user' do
      it { should belong_to(:user) }
    end

    context 'methods' do
      let(:address) { "Kostava, Kutaisi, Imereti, Georgia" }

      it "address" do
        expect(location.address).to eq(address)
      end
    end
  end
end

