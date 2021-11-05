class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.belongs_to :user
      t.string :name, null: false, default: ''
      t.text :description
      t.decimal :price, null: false, precision: 8, scale: 2, default: 1.00
      t.decimal :rating, null: false, precision: 2, scale: 1, default: 5.0

      t.timestamps
    end
  end
end
