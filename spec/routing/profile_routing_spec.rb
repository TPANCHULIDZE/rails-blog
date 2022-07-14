require "rails_helper"

RSpec.describe ProfileController, type: :routing do
  describe "profile" do
    it "routes to #profile" do
      expect(get: "users/:id/profile").to route_to({
        controller: "profile",
        action: "profile",
        id: ":id"
      })
    end
  end
end