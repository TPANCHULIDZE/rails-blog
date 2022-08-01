require "rails_helper"

RSpec.describe ChargesController, type: :routing do
  describe "Charges" do
    it "routes to #new" do
      expect(get: "/users/charges/new").to route_to({
        controller: "charges",
        action: "new",
      })   
    end

    it "routes to #create" do
      expect(post: "/users/charges/create").to route_to({
        controller: "charges",
        action: "create",
      })
    end
  end
end

