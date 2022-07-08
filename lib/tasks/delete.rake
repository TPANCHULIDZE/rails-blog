require 'date'
namespace :delete do
  desc "delete post"
  task post: :environment do
    posts = Post.where("created_at <= ? AND approve = ?", (Time.now - 10.days), true)
    posts.each do |post|
      post.destroy if post.likes.empty?
    end
  end
end
