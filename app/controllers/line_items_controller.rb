# frozen_string_literal: true

class LineItemsController < ApplicationController
  before_action :set_current_order

  def create
    @line_item = @order.line_items.build(line_item_params)
    existing_order = @order.line_items.where(product_id: params[:line_item][:product_id])
    finalize_existing_order(existing_order)
    session[:order_id] = @order.id
  end

  def update
    @line_item = @order.line_items.find(params[:id])
    @line_item.update(line_item_params)
    @line_items = @order.line_items
  end

  def destroy
    @line_item = @order.line_items.find(params[:id])
    @line_item.destroy
    @line_items = @order.line_items
  end

  private

  def set_current_order
    @order = current_order
  end

  def line_item_params
    params.require(:line_item).permit(:quantity, :product_id)
  end

  def finalize_existing_order(existing_order)
    if existing_order.count >= 1
      existing_order.last.update(quantity: existing_order.last.quantity + params[:line_item][:quantity].to_i)
    else
      @order.save
    end
  end
end
