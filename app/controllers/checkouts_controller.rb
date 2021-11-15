# frozen_string_literal: true

class CheckoutsController < ApplicationController
  before_action :set_checkout, only: [:show]
  before_action :set_order_and_line_items, only: %i[new create]

  def index
    if current_user
      @checkouts = current_user.checkouts
    else
      redirect_to root_path
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
    @checkout.build_order
    # update_total
    @checkout.total = @order.subtotal
    if @checkout.save
      finalize_checkout
    else
      redirect_to new_checkout_path(order_id: @order.id)
    end
  end

  private

  def set_order_and_line_items
    @order = Order.find_by(id: params[:order_id])
    @line_items = @order.line_items
  end

  def update_total
    @checkout.total = @order.subtotal
  end

  def finalize_checkout
    @order.update(checkout_id: @checkout.id)
    session.delete(:order_id)
    session[:checkout_id] = @checkout.id
    order = current_user ? current_user.orders.build : Order.new
    order.save
    redirect_to @checkout
  end

  def set_checkout
    @checkout = Checkout.find_by(slug: params[:slug])
  end

  def checkout_params
    params.require(:checkout).permit(:name, :email, :address, :phone_number, :order_id, :user_id)
  end
end
