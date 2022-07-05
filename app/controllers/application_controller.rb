class ApplicationController < ActionController::Base
  before_action :set_locale

  private 

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def require_user_signed_in!
    redirect_to user_session_path, notice: "you have to sign in first" unless user_signed_in? 
  end
end
