require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "before actions" do
    it { expect(controller).to use_before_action(:set_locale) }
  end

  describe "user not signed" do
    before { get :index }

    it { should render_template(:index) }
  end
end

