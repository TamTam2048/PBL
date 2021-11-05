class ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.build(@product)
    if @product.save
      redirect_to root_path
    else
      redirect_to new_product_path
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :description, :image)
  end
end
