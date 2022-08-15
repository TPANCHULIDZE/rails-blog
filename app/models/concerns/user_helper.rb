module UserHelper
  extend ActiveSupport::Concern

  included do
    private
    
    def set_default_status
      self.status ||= :guest
    end
  end

  class_methods do
    def from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.username = auth.info.name
        user.skip_confirmation!
      end
    end
  end
end

