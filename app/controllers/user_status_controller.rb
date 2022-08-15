class UserStatusController < ApplicationController
  include UserStatusSupport
  
  before_action :require_user_signed_in! 
  before_action :set_user
  before_action :require_authorize_user!
end

