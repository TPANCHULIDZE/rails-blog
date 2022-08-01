class HomeController < ApplicationController
  decorates_assigned :posts

  def index
    @q = Post.ransack(params[:q])
    @p = @q.result(distinct: true)
    @posts = @p.where(approve: true).paginate(page: params[:page], per_page: 10)
  end

  def change_laguage
    I18n.locale = params[:language]
  end
end
