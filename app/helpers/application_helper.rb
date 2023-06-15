module ApplicationHelper
  def bootstrap_alert(key)
    case key
    when "alert"
      "warning"
    when "notice"
      "success"
    when "error"
      "danger"
    when "secondary"
      "secondary"
    when "success"
      "success"
    when "danger"
      "danger"
    when "warning"
      "warning"
    when "info"
      "info"
    when "light"
      "light"
    when "dark"
      "dark"
    end
  end
end
