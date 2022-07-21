class PostDecorator < ApplicationDecorator
  include Draper::LazyHelpers
  delegate_all
  
  def self.collection_decorator_class
    PaginatingDecorator
  end

  def is_liked?(user_id)
    @like = self.likes.find_by(user_id: user_id)
    !!@like
  end

  def like()
    @like
  end

  def edit_post
    link_to translate("edit_this_post"), edit_post_path(post), class: "btn btn-success btn-block btn-lg gradient-custom-4 text-body"
  end

  def delete_post
    button_to translate("delete_post"), post, method: :delete, class: "btn btn-success btn-block btn-lg gradient-custom-4 text-body"
  end

  def title_and_status
    post.title 
  end

  def is_approve?
    if post.approve 
      render  "comments/show", post: post
    end 
  end

  def approve_post
    if post.approve
      link_to translate("back_to_posts"), posts_path, class: "btn btn-success btn-block btn-lg gradient-custom-4 text-body"
    elsif current_user.admin?
      link_to translate("approve_post"), approve_post_path(post), data: { turbo_method: :post }, class: "btn btn-success btn-block btn-lg gradient-custom-4 text-body"
    else 
      return
    end
  end

  def author
    link_to user.username, profile_path(user), class: "nav-link"  
  end

  def published_time
    post.created_at.strftime('%A, %B %e')
  end

  def show_comment
    link_to translate("comments"), nil, remote: true, data: {
      controller: "comments",
      action: "comments#myComment"
    }, class: "btn btn-primary" 
  end

  def show
    link_to translate("back_to_post"), post, class: "btn btn-success btn-block btn-lg gradient-custom-4 text-body" 
  end

  def show_all
    link_to translate("back_to_posts"), posts_path, class: "btn btn-success btn-block btn-lg gradient-custom-4 text-body"
  end

  def back_status
    return "member_only" if post.member_only
    
    "free"
  end
end
