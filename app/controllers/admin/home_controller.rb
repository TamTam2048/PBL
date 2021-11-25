# frozen_string_literal: true

module Admin
  class HomeController < ApplicationController
    def index
      cards_information
      tables_information
      chart_information
    end

    private

    def cards_information
      @user_count = User.count
      @product_count = Product.count
      @order_count = Checkout.count
    end

    def tables_information
      @checkouts = Checkout.last(5)
      @users = User.last(5)
      @products = Product.last(5)
    end

    def chart_information
      @total = Checkout.pluck(:total).sum
    end
  end
end
