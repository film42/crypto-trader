class Transaction < ActiveRecord::Base

  attr_accessible :buy_amount, :buy_rate_usd, :buy_currency_code
  attr_accessible :using_rate_usd, :using_currency_code
  attr_accessible :total, :total_usd, :new_balance
  attr_accessible :status

  attr_accessible :service_charge

  belongs_to :user

end

