# frozen_string_literal: true

class CheckoutsController < ApplicationController
  before_action :set_checkout, only: [:show]
  before_action :set_order_and_line_items, only: %i[new create]

  def index
    if current_user
      @checkouts = current_user.checkouts
    else
      redirect_to root_path
      flash[:notice] = "Please login before you proceed"
    end
  end

  def show
    @order = @checkout.order
    @line_items = @order.line_items
  end

  def new
    @checkout = Checkout.new
  end

  def create
    @checkout = Checkout.new(checkout_params)
    return if @order.blank?
    @checkout.user_id = current_user.id if current_user
    update_total
    if @checkout.save
      finalize_order
      finalize_checkout
    else
      redirect_to new_checkout_path(order_id: @order.id)
      flash[:danger] = "An error occurred. Please try again"
    end
  end

  private

  def set_order_and_line_items
    @order = Order.find_by(id: params[:order_id])
    @line_items = @order.line_items
  end

  def update_total
    @checkout.total = @order.line_items.sum { |line_item| line_item.product.price * line_item.quantity }
  end

  def finalize_order
    @order.update(checkout_id: @checkout.id)
    @order.line_items.each do |line_item|
      line_item.update(unit_price: line_item.product.price, total_price: line_item.product.price * line_item.quantity)
    end
  end

  def finalize_checkout
    session.delete(:order_id)
    session[:checkout_id] = @checkout.id
    order = current_user ? current_user.orders.build : Order.new
    order.save
    redirect_to @checkout
    flash[:success] = "Your order has been created successfully"
  end

  def set_checkout
    @checkout = Checkout.find_by(slug: params[:slug])
  end

  def checkout_params
    params.require(:checkout).permit(:name, :email, :address, :phone_number, :order_id)
  end
end
