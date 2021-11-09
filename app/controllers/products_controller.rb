# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :valid_user,  only: %i[edit update destroy]

  def index
    @products = Product.all.with_attached_image
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      redirect_to product_path(@product)
    else
      redirect_to new_product_path
    end
  end

  def edit; end

  def update
    @product.update(product_params)
    if @product.save
      redirect_to user_path(current_user)
    else
      redirect_to edit_product_path(@product)
    end
  end

  def destroy
    @product.image.purge if @product.image.attached?
    @product.destroy
    redirect_to request.referer || products_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def valid_user
    redirect_to root_path if @product.user_id != current_user.id
  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :image)
  end
end
