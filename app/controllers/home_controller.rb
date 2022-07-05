class HomeController < ApplicationController
  decorates_assigned :posts

  def index
    @posts = Post.paginate(page: params[:page], per_page: 2)
  end

  def change_laguage
    I18n.locale = params[:language]
  end
end
