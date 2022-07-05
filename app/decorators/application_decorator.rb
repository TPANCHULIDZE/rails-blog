class ApplicationDecorator < Draper::Decorator
  def translate(string)
    I18n.t(string.to_sym)
  end
end
