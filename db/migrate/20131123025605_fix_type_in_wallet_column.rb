class FixTypeInWalletColumn < ActiveRecord::Migration
  def up
    remove_column :wallets, :nmc_balance
    add_column :wallets, :nmc_balance, :decimal, precision: 20, scale: 5
  end

  def down
  end
end
