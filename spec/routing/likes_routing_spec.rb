require "rails_helper"

RSpec.describe LikesController, type: :routing do
  describe "likes" do

    it "no #index routes" do
      expect(get: "/posts/:post_id/likes").not_to be_routable
    end

    it "no #show routes" do
      expect(get: "/posts/:post_id/likes/:id").not_to be_routable
    end

    it "no #new routes" do
      expect(get: "/posts/:post_id/likes/new").not_to be_routable
    end

    it "routes to #create" do
      expect(post: "/posts/:post_id/likes").to route_to({
        controller: "likes",
        action: "create",
        post_id: ":post_id"
      })
    end

    it "no #edit routes" do
      expect(get: "posts/:post_id/likes/:id/edit").not_to be_routable
    end

    it "no #update routes" do
      expect(patch: "/posts/:post_id/likes/:id").not_to be_routable
    end

    it "routes to #destroy" do
      expect(delete: "/posts/:post_id/likes/:id").to route_to({
        controller: "likes",
        action: "destroy",
        post_id: ":post_id",
        id: ":id"
      })
    end
  end
end