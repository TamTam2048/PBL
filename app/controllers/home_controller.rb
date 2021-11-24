# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.role == "admin"
      redirect_to admin_root_path
    else
      redirect_to products_path
    end
  end
end
