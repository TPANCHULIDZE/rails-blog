class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_locale

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You have to be member or admin for this action"
    redirect_back(fallback_location: root_path)
  end

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
