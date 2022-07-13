class CommentDecorator < ApplicationDecorator
  include Draper::LazyHelpers

  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def is_current_user_author?(current_user)
    self.user == current_user  
  end

  def edit_comment(current_user)
    if is_current_user_author?(current_user)
      link_to translate("edit"), nil, class: "btn btn-success", id: "edit_comment", remote: true, data: {
        controller: "comments",
        action: "comments#taggleForm",
        comments_form_param: "edit-form-#{ comment.id }"
      } 
    end
  end

  def author_avatar
    author = self.user
    if author.avatar?
      author.avatar_url
    else
      "avatar.png"
    end
  end

  def commet_author
    self.user.username
  end

  def delete_comment(current_user)
    if is_current_user_author?(current_user)
      button_to translate("delete"), post_comment_path(comment.post, comment), method: :delete, class: "btn btn-danger", id: "delete_comment"
    end
  end
end
