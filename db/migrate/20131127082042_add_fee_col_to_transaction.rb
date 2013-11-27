class AddFeeColToTransaction < ActiveRecord::Migration
  def change

    add_column :transactions, :service_chare, :decimal, precision: 20, scale: 5

  end
end
