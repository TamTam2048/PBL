# frozen_string_literal: true

module ProductsHelper
  def time_since(utc)
    DateTime.parse(utc.to_s).strftime("%I:%M %p")
  end
end
