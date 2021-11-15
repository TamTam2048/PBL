class RemoveUnitPriceAndTotalPriceFromLineItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :line_items, :unit_price
    remove_column :line_items, :total_price
  end
end
