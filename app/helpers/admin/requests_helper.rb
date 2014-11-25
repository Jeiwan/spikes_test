module Admin::RequestsHelper
  def request_status(status)
    case status
    when 'fresh'
      'Новая'
    when 'pending'
      'Ожидание'
    when 'executed'
      'Выполнена'
    end
  end

  def request_controls(request)
    case request.status
    when 'fresh'
      raw("#{link_to 'Редактировать', '#'} | #{link_to 'Подтвердить', '#'}")
    when 'pending'
      link_to 'Приходовать', new_admin_request_invoice_path(request.id)
    when 'executed'
    end
  end
end
