class PostDecorator < ApplicationDecorator
  delegate_all
  def self.collection_decorator_class
    PaginatingDecorator
  end

  def is_liked?(user)
    @like = self.likes.find_by(user_id: user.id)
    !!@like
  end

  def like()
    @like
  end
end
