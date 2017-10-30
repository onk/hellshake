module ApplicationHelper
  def name_with_avatar(user)
    link_to(user_path(username: user.username), class: "valign-wrapper") do
      image_tag(user.image_url, size: "24x24", class: "valign") + content_tag(:span, user.name, class: "valign")
    end
  end

  def presentation_image_tag(presentation)
    # TODO: 変換中を表現するメソッドを model に用意
    if presentation.image_file?
      image_tag(presentation.image_file_url, class: "blockimage")
    else
      image_tag("converting.png", size: "250x187", alt: "変換中", class: "blockimage")
    end
  end

  def material_icon(name, options = {})
    classes = Array(options.delete(:class)) + ["material-icons"]
    content_tag(:i, name, options.merge(class: classes))
  end
  alias_method :mi, :material_icon
end
