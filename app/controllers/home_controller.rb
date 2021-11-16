# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all
    @line_item = current_order.line_items.new
  end
end
