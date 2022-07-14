require "rails_helper"

RSpec.describe CommentsController, type: :routing do
  describe "comments" do
    it "no #index routes" do
      expect(get: "posts/:post_id/comments").not_to be_routable
    end

    it "no #show routes" do
      expect(get: "posts/:post_id/comments/:id").not_to be_routable
    end

    it "no #new routes" do
      expect(get: "/posts/:post_id/comments/new").not_to be_routable
    end

    it "routes to #create" do
      expect(post: "/posts/:post_id/comments").to route_to({
        controller: "comments",
        action: "create",
        post_id: ":post_id"
      })
    end

    it "no #edit routes" do
      expect(get: "/posts/:post_id/comments/edit").not_to be_routable
    end
    
    it "routes to #update" do
      expect(patch: "/posts/:post_id/comments/:id").to route_to({
        controller: "comments",
        action: "update",
        post_id: ":post_id",
        id: ":id"
      })
    end

    it "routes to #destroy" do
      expect(delete: "/posts/:post_id/comments/:id").to route_to({
        controller: "comments",
        action: "destroy",
        post_id: ":post_id",
        id: ":id"
      })
    end

  end

end