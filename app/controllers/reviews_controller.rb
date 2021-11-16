# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :set_product, only: %i[new create]

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.new(review_params)
    @review.product_id = @product.id
    if @review.save
      @product.update_product_rating
    else
      redirect_to product_path(@product)
    end
  end

  private

  def set_product
    @product = Product.find_by(id: params[:product_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
