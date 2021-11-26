# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :set_product
  before_action :set_review, only: %i[edit update destroy]

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      @review = Review.new
    else
      redirect_to product_path(@product)
      flash[:danger] = "An error occurred. Please try again"
    end
  end

  def edit; end

  def update
    @review.update(review_params)
    if @review.save
      redirect_to product_path(@product)
      flash[:success] = "Your comment has been updated"
    else
      redirect_to edit_product_review_path(@product.id, @review.id)
      flash[:danger] = "An error occurred. Please try again"
    end
  end

  def destroy
    @review.destroy
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def set_product
    @product = Product.find_by(id: params[:product_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating).merge(product_id: params[:product_id])
  end
end
