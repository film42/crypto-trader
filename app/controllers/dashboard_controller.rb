class DashboardController < ApplicationController

  before_filter :authenticate_user!

  def index 

    @btc_currency = Currency.where(pair: "btc_usd").first
    @ltc_currency = Currency.where(pair: "ltc_usd").first
    @nmc_currency = Currency.where(pair: "nmc_usd").first

    @transactions  = current_user.transactions.limit(15).reverse_order

    @buy_select_options   = [ ['BitCoin (Default)', 'BTC'],  ['US Dollar', 'USD'],
                              ['LiteCoin', 'LTC'], ['NameCoin', 'NMC'] ]

    @using_select_options = [ ['US Dollar (Default)', 'USD'],  ['BitCoin', 'BTC'],
                              ['LiteCoin', 'LTC'], ['NameCoin', 'NMC'] ]

    @transaction = Transaction.new

  end

  def leaderboard

    @btc_currency = Currency.where(pair: "btc_usd").first
    @ltc_currency = Currency.where(pair: "ltc_usd").first
    @nmc_currency = Currency.where(pair: "nmc_usd").first

    @transactions  = current_user.transactions.limit(15).reverse_order

    @buy_select_options   = [ ['BitCoin (Default)', 'BTC'],  ['US Dollar', 'USD'],
                              ['LiteCoin', 'LTC'], ['NameCoin', 'NMC'] ]

    @using_select_options = [ ['US Dollar (Default)', 'USD'],  ['BitCoin', 'BTC'],
                              ['LiteCoin', 'LTC'], ['NameCoin', 'NMC'] ]

    @transaction = Transaction.new

  end

  def new_transaction 
    # Get Codes
    buy_code = params[:transaction][:buy_currency_code]
    using_code = params[:transaction][:using_currency_code]
    # Get the last rates
    buy_rate = 1 
    if(buy_code != "USD")
      buy_rate = Currency.where(pair: get_conversion_code(buy_code)).first.last
    end
    using_rate = 1 # Assume USD
    if(using_code != "USD")
      using_rate = Currency.where(pair: get_conversion_code(using_code)).first.last
    end

    # Get Amount to purchase
    amount = BigDecimal.new(params[:transaction][:buy_amount])
    if amount == 0
      flash[:error] = "Error, Amount Required"
      redirect_to dashboard_path
      return
    end

    # New Exchange Rates
    real_rate = (buy_rate / using_rate)
    fee = real_rate * amount * BigDecimal.new("0.06")

    # Create Record
    transaction = Transaction.new 
    transaction.buy_amount = amount
    transaction.buy_rate_usd = buy_rate
    transaction.buy_currency_code = buy_code
    transaction.using_rate_usd = using_rate
    transaction.using_currency_code = using_code
    transaction.service_charge = fee
    transaction.total = ((real_rate * amount) - fee)
    transaction.total_usd = ((real_rate * amount) - fee) * using_rate

    # Max Logic Test here please
    wallet = current_user.wallet

    if wallet[get_wallet_code(using_code)] < real_rate * amount
      flash[:error] = "Error, Insufficient Funds"
      redirect_to dashboard_path
      return
    end

    # Subtract from wallet's using amount
    wallet[get_wallet_code(using_code)] -= (real_rate * amount)
    # Increment the purchased amount now
    wallet[get_wallet_code(buy_code)] += ((real_rate * amount) * using_rate - fee) / buy_rate

    wallet.save

    # This transaction is done
    transaction.status = "success"
    transaction.new_balance = wallet.balance

    # Assign this
    transaction.user = current_user
    transaction.save

    flash[:notice] = "Transaction was successful!"
    redirect_to dashboard_path
  end


  private

    def get_conversion_code(code)
      code.downcase + "_usd"
    end

    def get_wallet_code(code)
      code.downcase + "_balance"
    end


end
