module Admin::DashboardHelper
  def is_active?(controller, action=nil)
    action ||= params[:action]
    (params[:controller] == controller && params[:action] == action) ? 'active' : ''
  end
end
