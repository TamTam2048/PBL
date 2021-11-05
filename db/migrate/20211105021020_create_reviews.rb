class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.belongs_to :user
      t.belongs_to :product
      t.text :content, presence: true
      t.decimal :rating, null: false, precision: 2, scale: 1

      t.timestamps
    end
  end
end
