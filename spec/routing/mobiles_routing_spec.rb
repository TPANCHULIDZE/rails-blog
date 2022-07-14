require "rails_helper"

RSpec.describe MobilesController, type: :routing do
  describe "mobiles" do
    it "routes to #new" do
      expect(get: "users/mobile_phone").to route_to("mobiles#new")
    end

    it "routes to #create" do
      expect(post: "users/mobile_phone").to route_to("mobiles#create")
    end

    it "routes to #destroy" do
      expect(delete: "users/:user_id/mobile_phone/delete/:id").to route_to({
        controller: "mobiles",
        action: "destroy",
        user_id: ":user_id",
        id: ":id"
      })
    end
  end
end