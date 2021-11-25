# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show update]

  def show
    @products = Product.where(user_id: @user.id)
  end

  def update
    @user.update(user_params)
    if @user.save
      flash[:success] = "Updated profile successfully"
    else
      flash[:danger] = "An error occurred. Please try again"
    end
    redirect_to user_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
