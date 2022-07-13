class UserDecorator < ApplicationDecorator
  include Draper::LazyHelpers
  delegate_all 

  def avatar_image_url
    if self.avatar? 
      self.avatar_url
    else 
      "avatar.png"
    end 
  end

  def authors_posts
    user.username + "'" + translate("s") + " " + translate("posts")
  end

  def member_since
    self.created_at.strftime("%Y-%m-%d")
  end

  def first_number
    numbers = user.mobiles
    numbers.first ? numbers.first.number : translate("no_number") 
  end

  def first_address
    address = user.locations
    address.first ? address.first.address : translate("no_address") 
  end

  def first_3address
    self.locations.first(3)
  end

  def first_3numbers
    self.mobiles.first(3)
  end

  def delete_number(mobile_id, current_user)
    if is_user_admin_or_current_user?(current_user)
      link_to translate("delete"), destroy_mobile_path(self.id, mobile_id), data:{
        turbo_method: :delete
      } 
    end
  end

  def add_number(current_user)
    if is_user_current_user?(current_user)
      link_to translate("add_number"), users_mobile_phone_path
    end
  end

  def add_address(current_user)
    if is_user_current_user?(current_user)
      link_to translate("add_address"), add_location_path
    end
  end
  
  def delete_address(current_user, address_id)
    if is_user_admin_or_current_user?(current_user)
      link_to translate("delete"), destroy_address_path(self.id, address_id), data: {
        turbo_method: :delete
      }, class: "btn btn-danger"
    end
  end

  def posts
    link_to translate("posts"), user_post_path(self.id)
  end

  def become_guest
    link_to translate("become_guest"), become_guest_path(user), data: { turbo_method: :post }, class: "nav-link"
  end

  def become_member
    link_to translate("become_member"), become_member_path(user), data: { turbo_method: :post }, class: "nav-link"
  end

  def become_admin
    link_to translate("become_admin"), become_admin_path(user), data: { turbo_method: :post }, class: "nav-link"
  end

  def show_location(location)
    link_to location.address, nil, remote: true, data: { 
      controller: "locations",
      action: "locations#initMap",
      locations_latitude_param: "#{location.latitude}",
      locations_longitude_param: "#{location.longitude}"
    } 
  end
  private

  def is_user_current_user?(current_user)
    self == current_user
  end

  def is_user_admin_or_current_user?(current_user)
    current_user.admin? || self == current_user 
  end
end
