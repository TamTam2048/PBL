# frozen_string_literal: true

module Admin
  class ApplicationController < ApplicationController
    before_action :require_admin

    private

    def require_admin
      redirect_to root_path unless current_user&.admin?
    end
  end
end
