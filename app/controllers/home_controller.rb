class HomeController < ApplicationController
  def index
    @posts = Post.paginate(page: params[:page], per_page: 2)
  end
end
