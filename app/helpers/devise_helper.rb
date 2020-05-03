# frozen_string_literal: true

module DeviseHelper
  def bootstrap_alert(key)
    case key
    when 'alert'
      'danger'
    when 'notice'
      'success'
    when 'error'
      'warning'
    end
  end
end
