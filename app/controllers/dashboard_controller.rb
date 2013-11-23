class DashboardController < ApplicationController

  before_filter :authenticate_user!

  def index 

    @btc_currency = Currency.where(pair: "btc_usd").first
    @ltc_currency = Currency.where(pair: "ltc_usd").first
    @nmc_currency = Currency.where(pair: "nmc_usd").first

  end


end
