require 'date'
namespace :delete do
  desc "delete post"
  task post: :environment do
    indexs = Like.pluck(:post_id).uniq
    Post.where("created_at <= ? AND created_at >= ? AND approve = ?", (Time.now - 10.days), (Time.now - 12.days), true).where.not(id: indexs).destroy_all
  end
end
