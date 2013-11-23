class FixTypeInWalletColumnPartTwo < ActiveRecord::Migration
  def up
    remove_column :wallets, :btc_balacne
    add_column :wallets, :btc_balance, :decimal, precision: 20, scale: 5
  end

  def down
  end
end
