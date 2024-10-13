module ApplicationHelper

  def display_name_or_email(user)
    user.name.present? ? user.name : user.email_address
  end

  def avatarize(object)
    object[0, 2].capitalize
  end
end
