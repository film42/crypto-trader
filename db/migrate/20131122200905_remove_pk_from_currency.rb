class RemovePkFromCurrency < ActiveRecord::Migration
  def up
    remove_column :currencies, :exchange_id
  end

  def down
  end
end
