require 'rails_helper'

RSpec.describe User, type: :model do
  describe "user" do
    subject { create(:user) }
    
    context 'have many posts' do
      it { should have_many(:posts).dependent(:destroy) }
    end

    context 'have many comments' do
      it { should have_many(:comments).dependent(:destroy) }
    end

    context 'have many likes' do
      it { should have_many(:likes).dependent(:destroy) }
    end

    context  'have many mobiles' do
      it { should have_many(:mobiles).dependent(:destroy) }
    end

    context 'have_many locations' do
      it { should have_many(:locations).dependent(:destroy) }
    end

    context 'have validate username' do
      it { should validate_presence_of(:username) }
    end

    context 'have validate email' do
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email).case_insensitive }
    end

    context 'have validate password' do
      it { should validate_length_of(:password).is_at_least(6).on(:create) }
      it { should validate_confirmation_of(:password) }
    end

    context 'have validate status' do
      it { should validate_presence_of(:status)}
      it { should define_enum_for(:status).with_values(%i[guest member admin]) }
    end
  end
end
