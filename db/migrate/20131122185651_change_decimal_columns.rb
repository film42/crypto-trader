class ChangeDecimalColumns < ActiveRecord::Migration
  def up
    drop_table :currencies

    create_table :currencies do |t|
      t.decimal :last, precision: 10, scale: 5
      t.decimal :average, precision: 10, scale: 5
      t.decimal :volume, precision: 10, scale: 5
      t.decimal :volume_current, precision: 10, scale: 5
      t.decimal :high, precision: 10, scale: 5
      t.decimal :low, precision: 10, scale: 5
      t.decimal :pair, precision: 10, scale: 5

      t.integer :exchange_id

      t.timestamps
    end
  end

  def down
  end
end
