# frozen_string_literal: true

module Admin
  class ProductsController < ApplicationController
    before_action :set_product, only: %i[edit update destroy]

    def index
      @products = Product.with_attached_image.page params[:page]
    end

    def edit; end

    def update
      @product.update(product_params)
      if @product.save
        redirect_to admin_products_path
        flash[:success] = "Updated product successfully"
      else
        redirect_to edit_admin_product_path(@product)
        flash[:danger] = "An error occurred. Please try again"
      end
    end

    def destroy
      @product.image.purge if @product.image.attached?
      @product.destroy
      redirect_to request.referer || admin_products_url
      flash[:success] = "Products has been deleted successfully"
    end

    private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :price, :rating, :image)
    end
  end
end
