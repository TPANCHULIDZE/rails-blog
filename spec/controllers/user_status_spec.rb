require "rails_helper"

RSpec.describe UserStatusController, type: :controller do
  login_admin

  describe "before action methods" do
    it { expect(controller).to use_before_action(:set_locale) }
    it { expect(controller).to use_before_action(:require_user_signed_in!) }
    it { expect(controller).to use_before_action(:set_user) }
    it { expect(controller).to use_before_action(:require_authorize_user!) }
  end
end