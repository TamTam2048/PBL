class UpdateUnitPriceAndTotalPriceForLineItems < ActiveRecord::Migration[6.1]
  def change
    change_column :line_items, :unit_price, :decimal, null: false, precision: 12, scale: 2, default: 0
    change_column :line_items, :total_price, :decimal, null: false, precision: 12, scale: 2, default: 0
  end
end
