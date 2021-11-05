class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user
      t.belongs_to :checkout
      t.integer :status, null: false, default: 0
      t.decimal :subtotal, precision: 12, scale: 2

      t.timestamps
    end
  end
end
