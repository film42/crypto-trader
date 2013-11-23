class Addpktotransaction < ActiveRecord::Migration
  def up
    add_column :transactions, :user_id, :integer
  end

  def down
  end
end
