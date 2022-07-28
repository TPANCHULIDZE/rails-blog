module ControllerMacros
  def login_user
    before(:each) do
      user = FactoryBot.create(:user)
      sign_in user
    end
  end

  def login_admin
    before(:each) do
      user = FactoryBot.create(:user)
      user.update(status: 2)
      sign_in user
    end
  end
end
