module ApplicationHelper
  def dropdown_button_item(classes, link, text)
    s = '<a class="dropdown-item ' + classes + '" href="' + link + '" data-method="post" rel="nofollow">' + text + '</a>'
    # "<a rel=\"nofollow\" data-method=\"post\" href=\"/todos/done/1\">Done</a>"
    s.html_safe
  end
end
