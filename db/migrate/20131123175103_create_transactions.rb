class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|

      t.decimal :buy_amount,     :precision => 20, :scale => 5
      t.decimal :buy_rate_usd, :precision => 20, :scale => 5
      t.string  :buy_currency_code

      t.decimal :using_rate_usd, :precision => 20, :scale => 5
      t.string  :using_currency_code

      t.decimal :total, :precision => 20, :scale => 5
      t.decimal :total_usd, :precision => 20, :scale => 5


      t.decimal :new_balance, :precision => 20, :scale => 5

      t.timestamps
    end
  end
end

