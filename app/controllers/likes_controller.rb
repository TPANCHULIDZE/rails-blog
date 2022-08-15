class LikesController < ApplicationController
  include LikesSupport
  
  before_action :require_user_signed_in!
  before_action :set_post, only: %i[ create destroy]
  before_action :set_like, only: %i[ destroy ]

  def create
    @post.likes.create(user_id: current_user.id)
    redirect_to @post
  end

  def destroy
    @like.destroy
    redirect_to @post, status: 303
  end
end
