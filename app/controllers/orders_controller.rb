# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_order, only: %i[new show]

  def index
    @order = Order.order("created_at DESC")
  end

  def show; end

  def new; end

  def create
    @order = current_user.orders.build(order_params)
    if @order.save
      redirect_to @order
    else
      redirect to "new"
    end
  end

  private

  def order_params
    params.require(:order).permit(:total, :subtotal)
  end

  def set_order
    if current_user
      @order = current_user.orders.find(params[:order_id])
    elsif !session[:order_id].nil?
      @order = Order.find(session[:order_id])
    else
      redirect_to root_path
    end
    order_present
  end

  def order_present
    redirect_to root_path unless @order
  end
end
