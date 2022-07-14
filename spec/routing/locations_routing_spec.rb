require "rails_helper"

RSpec.describe LocationsController, type: :routing do
  describe "locations" do
    it "routes to #index" do
      expect(get: "/users/:user_id/locations/all").to route_to({
        controller: "locations",
        action: "index",
        user_id: ":user_id"
      })
    end

    it "routes to #show" do
      expect(get: "/users/locations/show/:id").to route_to({
        controller: "locations",
        action: "show",
        id: ":id"
      })
    end

    it "routes to #new" do
      expect(get: "/users/locations/add").to route_to("locations#new")
    end

    it "routes to #create" do
      expect(post: "/users/locations/add").to route_to("locations#create")
    end

    it "routes to #destroy" do
      expect(delete: "/users/:user_id/locations/delete/:id").to route_to({
        controller: "locations",
        action: "destroy",
        user_id: ":user_id",
        id: ":id"
      })
    end 
  end
end