class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.string :ticker
      t.string :name
      t.string :last_price
      t.string :decimal

      t.timestamps
    end
  end
end
