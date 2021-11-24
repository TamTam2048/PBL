# frozen_string_literal: true

module Admin
  class CheckoutsController < ApplicationController
    def index
      @checkouts = Checkout.all
    end

    def update; end
  end
end
