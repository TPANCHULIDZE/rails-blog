require "rails_helper"

RSpec.describe UserStatusController, type: :routing do
  describe "user_status" do
    it "routes to #user_become_guest" do
      expect(patch: "users/status/guest/:id").to route_to({
        controller: "user_status",
        action: "user_become_guest",
        id: ":id"
      })
    end

    it "routes to #user_become_member" do
      expect(patch: "users/status/member/:id").to route_to({
        controller: "user_status",
        action: "user_become_member",
        id: ":id"
      })
    end

    it "routes to #user_become_admin" do
      expect(patch: "users/status/admin/:id").to route_to({
        controller: "user_status",
        action: "user_become_admin",
        id: ":id"
      })
    end
  end
end

