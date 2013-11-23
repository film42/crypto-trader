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

  def new_transaction 

      #attr_accessible :, :buy_rate_usd, :
      #attr_accessible :using_rate_usd, :using_currency_code
      #attr_accessible :total, :total_usd, :new_balance
      #attr_accessible :status

    # THROW ERROR IF
      # 1) not all filled out including 0
      # 2) no funds

    # Get Codes
    buy_code = params[:transaction][:buy_currency_code]
    using_code = params[:transaction][:using_currency_code]
    # Get the last rates
    puts "*******"
    puts get_conversion_code(using_code)
    buy_rate = 1 
    if(buy_code != "USD")
      Currency.where(pair: get_conversion_code(buy_code)).first.last
    end
    using_rate = 1 # Assume USD
    if(using_code != "USD")
      using_rate = Currency.where(pair: get_conversion_code(using_code)).first.last
    end

    # Get Amount to purchase
    amount = BigDecimal.new(params[:transaction][:buy_amount])

    # New Exchange Rates
    puts using_rate
    puts "****"
    real_rate = (buy_rate / using_rate)

    # Create Record
    transaction = Transaction.new 
    transaction.buy_amount = amount
    transaction.buy_rate_usd = buy_rate
    transaction.buy_currency_code = buy_code

    transaction.using_rate_usd = using_rate
    transaction.using_currency_code = using_code

    fee = real_rate * amount * BigDecimal.new("0.06")

    transaction.total = ((real_rate * amount) - fee)
    transaction.total_usd = ((real_rate * amount) - fee) * using_rate

    # Max Logic Test here please
    wallet = current_user.wallet

    if wallet[get_wallet_code(using_code)] < real_rate * amount
      raise Exception.new "Can't do this"
    end

    # Subtract from wallet's using amount
    wallet[get_wallet_code(using_code)] -= (real_rate * amount)
    # Increment the purchased amount now
    wallet[get_wallet_code(buy_code)] += (real_rate * amount) * using_rate * BigDecimal.new("0.06")

    wallet.save

    # This transaction is done
    transaction.status = "success"
    transaction.new_balance = wallet.balance

    # Assign this
    transaction.user = current_user
    transaction.save

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
