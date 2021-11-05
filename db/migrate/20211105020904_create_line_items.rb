# frozen_string_literal: true

class CreateLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items do |t|
      t.belongs_to :product
      t.belongs_to :order
      t.integer :quantity
      t.decimal :unit_price, null: false, precision: 12, scale: 2
      t.decimal :total_price, null: false, precision: 12, scale: 2

      t.timestamps
    end
  end
end
