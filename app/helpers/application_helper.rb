module ApplicationHelper
  def name_with_avatar(user)
    image_tag(user.image_url, size: "24x24") + link_to(user.name, user_path(username: user.username))
  end
end
