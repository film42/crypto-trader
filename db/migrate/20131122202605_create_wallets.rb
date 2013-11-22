class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
      t.decimal :btc_balacne, precision: 20, scale: 5
      t.decimal :ltc_balance, precision: 20, scale: 5
      t.decimal :nmc_balance, precision: 20, scale: 5
      t.decimal :usd_balance, precision: 20, scale: 5

      t.integer :user_id

      t.timestamps
    end
  end
end
