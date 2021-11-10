# frozen_string_literal: true

class CartsController < ApplicationController
  def show
    @order = current_order
    @line_items = current_order.line_items
  end
end
