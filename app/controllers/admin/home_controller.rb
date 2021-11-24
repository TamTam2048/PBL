# frozen_string_literal: true

module Admin
  class HomeController < ApplicationController
    def index
      generate_main_information
    end

    private

    def generate_main_information
      @user_count = User.count
      @product_count = Product.count
      @order_count = Checkout.count
    end
  end
end
