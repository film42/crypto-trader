class Wallet < ActiveRecord::Base
  attr_accessible :btc_balacne, :ltc_balance, :nmc_balance, :usd_balance

  belongs_to :user
end
