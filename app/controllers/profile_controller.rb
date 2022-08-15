class ProfileController < ApplicationController
  include ProfileSupport

  before_action :require_user_signed_in!
  
  decorates_assigned :user
end