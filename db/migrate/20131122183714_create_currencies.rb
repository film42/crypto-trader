class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|

      t.decimal :last, precision: 5
      t.decimal :average, precision: 5
      t.decimal :volume, precision: 5
      t.decimal :volume_current, precision: 5
      t.decimal :high, precision: 5
      t.decimal :low, precision: 5
      t.decimal :pair, precision: 5

      t.integer :exchange_id

      t.timestamps
    end
  end
end
