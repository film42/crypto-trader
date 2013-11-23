class Wallet < ActiveRecord::Base
  attr_accessible :btc_balance, :ltc_balance, :nmc_balance, :usd_balance

  belongs_to :user

  def balance
    btc_last = Currency.where(pair: "btc_usd").first.last
    ltc_last = Currency.where(pair: "ltc_usd").first.last
    nmc_last = Currency.where(pair: "nmc_usd").first.last

    (btc_last * btc_balance) + (ltc_last * ltc_balance) + (nmc_last * nmc_balance)
  end

end
