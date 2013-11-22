class AddBuyAndSellToCurrencies < ActiveRecord::Migration
  def change
    add_column :currencies, :buy , :decimal, precision: 20, scale: 5
    add_column :currencies, :sell, :decimal, precision: 20, scale: 5
  end
end
