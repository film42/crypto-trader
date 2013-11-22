class ExchangeController < ApplicationController
  def index 
    hash = {}
    Currency.all.each do |c | hash[c.pair] = c  end

    render json: hash    
  end

  def update
    begin
      pair   = params[:pair]
      
      ticker = Btce::Ticker.new pair

      currency = Currency.where(pair: pair).first || Currency.new

      currency.pair              = ticker.pair
      currency.low               = ticker.low
      currency.high              = ticker.high
      currency.last              = ticker.last
      currency.buy               = ticker.buy
      currency.sell              = ticker.sell

      currency.volume            = ticker.vol
      currency.volume_current    = ticker.vol_cur
      currency.average           = ticker.avg

      currency.save

      render json: currency
    rescue Exception => e 
      #puts e.message  
      #puts e.backtrace.join("\n")
      render json: {error: "bad pair key"}
    end
  end
end