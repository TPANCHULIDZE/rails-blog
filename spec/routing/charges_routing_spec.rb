require "rails_helper"

RSpec.describe ChargesController, type: :routing do
  describe "Charges" do
    it "routes to #new" do
      expect(get: "/users/:user_id/charges/new").to route_to({
        controller: "charges",
        action: "new",
        user_id: ":user_id"
      })   
    end

    it "routes to #create" do
      expect(post: "/users/:user_id/charges/create").to route_to({
        controller: "charges",
        action: "create",
        user_id: ":user_id"
      })
    end
  end
end

