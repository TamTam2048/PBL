# frozen_string_literal: true

module ApplicationHelper
  def toastr_flash(type)
    case type
    when "danger"
      "toastr.error"
    when "success"
      "toastr.success"
    else
      "toastr.info"
    end
  end
end
