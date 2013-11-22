class ChangePairToString < ActiveRecord::Migration
  def up
    drop_table :currencies

    create_table :currencies do |t|
      t.decimal :last, precision: 20, scale: 5
      t.decimal :average, precision: 20, scale: 5
      t.decimal :volume, precision: 20, scale: 5
      t.decimal :volume_current, precision: 20, scale: 5
      t.decimal :high, precision: 20, scale: 5
      t.decimal :low, precision: 20, scale: 5
      
      t.string :pair, :null => false

      t.integer :exchange_id

      t.timestamps
    end
  end

  def down
  end
end
