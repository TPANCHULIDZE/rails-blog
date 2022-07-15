require 'rails_helper'

RSpec.describe HomeController, type: :request do

  describe "GET /index" do
    before { get '/' }

    it { should render_template(:index) } 
  end
end
