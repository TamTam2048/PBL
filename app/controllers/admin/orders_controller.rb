# frozen_string_literal: true

module Admin
  class OrdersController < ApplicationController

    def index
      @orders = Order.where.not(checkout_id: nil)
    end

    def update
      @order = Order.find_by(id: params[:id])
      if @order.update(order_params)
        flash[:success] = "Update order status successfully"
      else
        flash[:danger] = "An error occurred. Please try again"
      end
      redirect_to admin_orders_path
    end

    private

    def order_params
      params.require(:order).permit(:status)
    end
  end
end
