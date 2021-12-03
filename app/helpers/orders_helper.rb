# frozen_string_literal: true

module OrdersHelper
  def filter_by_status(orders, status)
    orders.where(status: status)
  end
end
