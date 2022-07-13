class LikesController < ApplicationController
  before_action :require_user_signed_in!
  before_action :set_post, only: %i[ create destroy]
  before_action :set_like, only: %i[ destroy ]

  def new
  end

  def create
    @post.likes.create(user_id: current_user.id)
    redirect_to @post
  end

  def destroy
    @like.destroy
    redirect_to @post
  end


  private

  def set_post
    @post = Post.find_by(id: params[:post_id])
  end

  def set_like
    @like = Like.find_by(id: params[:id])
  end
end
