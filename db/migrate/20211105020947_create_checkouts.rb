class CreateCheckouts < ActiveRecord::Migration[6.1]
  def change
    create_table :checkouts do |t|
      t.belongs_to :user
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :address
      t.decimal :total, presence: true, precision: 12, scale: 2
      t.string :slug, null: false

      t.timestamps
    end
  end
end
