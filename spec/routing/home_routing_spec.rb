require "rails_helper"

RSpec.describe HomeController, type: :routing do
  describe "Home" do

    it "routes to #index" do
      expect(get: "/").to route_to("home#index")
    end
  end
end