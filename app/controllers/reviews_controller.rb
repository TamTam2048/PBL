# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :set_product
  before_action :set_review, only: %i[edit update destroy]

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.new(review_params)
    @review.product_id = @product.id
    if @review.save
      @product.update_product_rating
      @review = Review.new
    else
      redirect_to product_path(@product)
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
      flash[:success] = "An error occured. Please try again"
    end
  end

  def destroy
    @review.destroy
    flash[:success] = "Your comment has been deleted"
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def set_product
    @product = Product.find_by(id: params[:product_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
