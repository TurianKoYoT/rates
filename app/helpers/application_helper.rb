module ApplicationHelper
  def current_page_name
    "#{controller_name}-#{action_name}"
  end
end
