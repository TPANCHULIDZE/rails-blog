require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'Locations' do
    subject(:location) { FactoryBot.build(:location) }

    context 'belongs to user' do
      it { should belong_to(:user) }
    end

    context 'methods' do
      let(:address) { "Kostava, Kutaisi, Imereti, Georgia" }
      let(:coordinates) { [42.2345, 42.2323] }

      it "address" do
        expect(location.address).to eq(address)
      end

      it "coordinates" do
        expect(location.coordinates).to eq(coordinates)
      end
    end
  end
end

