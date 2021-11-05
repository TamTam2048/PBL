class CreateLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items do |t|
      t.belongs_to :product
      t.belongs_to :order
      t.decimal :unit_price, precision: 12, scale: 2
      t.integer :quantity
      t.decimal :total_price, precision: 12, scale: 2

      t.timestamps
    end
  end
end
