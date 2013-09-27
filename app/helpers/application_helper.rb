module ApplicationHelper
  # Public: Formats the name for User.
  #
  # user - User.
  # options - Hash for options.
  #
  # Returns formatted String.
  #
  def proper_name(user, options={})
    if user.title?
      title = I18n.t("global.title.#{user.title.downcase}")
      I18n.t("global.title_name", title: title, last_name: user.last_name)
    else
      I18n.t("global.full_name", first_name: user.first_name, last_name: user.last_name)
    end
  end
end
