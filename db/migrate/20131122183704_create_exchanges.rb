class CreateExchanges < ActiveRecord::Migration
  def change
    create_table :exchanges do |t|

      t.timestamps
    end
  end
end
