class Servicechargecoltypo < ActiveRecord::Migration
  def up

    remove_column :transactions, :service_chare
    add_column :transactions, :service_charge, :decimal, precision: 20, scale: 5

  end

  def down
  end
end
