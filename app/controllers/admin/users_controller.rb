# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :set_user, only: %i[update]

    def index
      @users = User.page params[:page]
    end

    def update
      @user.update(user_params)
      if @user.save
        flash[:success] = "Updated user successfully"
      else
        flash[:danger] = "An error occurred. Please try again"
      end
      redirect_to admin_users_path
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :role)
    end
  end
end
