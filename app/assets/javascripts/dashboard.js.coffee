# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  ###############################################
  #   Exchange                                  #
  ###############################################
  btc_last_usd       = 0
  ltc_last_usd       = 0
  nmc_last_usd       = 0

  usd_balance        = parseFloat $('.balance-usd').attr("data-value")
  btc_balance        = parseFloat $('.balance-btc').attr("data-value")
  ltc_balance        = parseFloat $('.balance-ltc').attr("data-value")
  nmc_balance        = parseFloat $('.balance-nmc').attr("data-value")


  ###############################################
  #   ELEMENTS                                     #
  ###############################################
  
  # Wallet
  balance_el            = $('.balance-total')

  # Exchange Rates
  btc_last_el           = $('.btc-last')
  btc_high_el           = $('.btc-high')
  btc_low_el            = $('.btc-low')
  btc_average_el        = $('.btc-average')

  ltc_last_el           = $('.ltc-last')
  ltc_high_el           = $('.ltc-high')
  ltc_low_el            = $('.ltc-low')
  ltc_average_el        = $('.ltc-average')

  nmc_last_el           = $('.nmc-last')
  nmc_high_el           = $('.nmc-high')
  nmc_low_el            = $('.nmc-low')
  nmc_average_el        = $('.nmc-average')

  # Trad Form
  buy_selector          = $('.buy-selector')
  using_selector        = $('.using-selector')
  transaction_amount    = $('.transaction-amount')
  transaction_subtotal  = $('.transaction-subtotal')
  transaction_fee       = $('.transaction-charge')
  transaction_total     = $('.transaction-total')

  ###############################################
  #   LOGIC                                     #
  ###############################################

  # Return in terms of USD
  getLastForCurrency = (tag) ->
    if tag == 'USD'
      return 1
    if tag == 'BTC'
      return btc_last_usd
    if tag == 'LTC'
      return ltc_last_usd
    if tag == 'NMC'
      return nmc_last_usd


  updateNewTransaction = () ->
    amount = transaction_amount.val()
    amount = parseFloat(amount)
    # make sure not to cause bugs
    return if not amount

    # :: Generalization ::
    # (Buy / Using) * Amount = subtotal 
    # (1 | .06% if USD) = charge
    # (subtotal * charge) = total
    
    buy_rate   = getLastForCurrency buy_selector.val()
    using_rate = getLastForCurrency using_selector.val()
    exchange_rate = buy_rate / using_rate
    subtotal = amount * exchange_rate
    fee = 0.006 * subtotal

    if buy_rate is 1 or using_rate is 1
      $('.fee-group').removeClass 'hidden'
    else 
      $('.fee-group').addClass 'hidden'
      fee = 0 # reset to none

    total = subtotal - fee

    transaction_subtotal.text(subtotal.toFixed(5))
    transaction_fee.text(fee.toFixed(5))
    transaction_total.text(total.toFixed(5))


  transaction_amount.keyup updateNewTransaction
  buy_selector.change updateNewTransaction
  using_selector.change updateNewTransaction

  ###############################################
  #   MARKET CHART                              #
  ###############################################

  start = 0
  btc_history = [{x: 0, y: 10}]
  ltc_history = [{x: 0, y: 10}]
  nmc_history = [{x: 0, y: 10}]

  logScale = d3.scale.log().domain([200, 900])
  series = [
      data: nmc_history
      color: 'rgba(0,144,217,0.51)'
      name:'Name Coin'
    ,
      data: ltc_history
      color: '#eceff1'
      name:'Lite Coin'
    ,
      data: btc_history
      color: '#6f7b8a'
      name:'Bit Coin'
      scale: logScale
    ]

  graph = new Rickshaw.Graph
    element: document.querySelector("#chart"),
    height: 200,
    renderer: 'area',
    series: series


  graph.render()
  hoverDetail = new Rickshaw.Graph.HoverDetail graph: graph

  updateCharts = () ->
    btc_history.push x: start, y: btc_last_usd
    ltc_history.push x: start, y: ltc_last_usd
    nmc_history.push x: start, y: nmc_last_usd

    start++
    graph.configure series : series 
    graph.update()

  ###############################################
  #   NETWORKING                                #
  ###############################################

  updateExchangeStats = (data) ->
    # Wallet
    balance = (btc_last_usd * btc_balance) + 
                (ltc_last_usd * ltc_balance) + 
                  (nmc_last_usd * nmc_balance) +
                    usd_balance

    balance_el.text balance.toFixed(2) unless balance == NaN

    # Exchange Rates
    btc_last_el.text(parseFloat(data.btc_usd.last).toFixed(2))
    btc_high_el.text(parseFloat(data.btc_usd.high).toFixed(2))
    btc_low_el.text(parseFloat(data.btc_usd.low).toFixed(2))
    btc_average_el.text(parseFloat(data.btc_usd.average).toFixed(2))

    ltc_last_el.text(parseFloat(data.ltc_usd.last).toFixed(2))
    ltc_high_el.text(parseFloat(data.ltc_usd.high).toFixed(2))
    ltc_low_el.text(parseFloat(data.ltc_usd.low).toFixed(2))
    ltc_average_el.text(parseFloat(data.ltc_usd.average).toFixed(2))

    nmc_last_el.text(parseFloat(data.nmc_usd.last).toFixed(2))
    nmc_high_el.text(parseFloat(data.nmc_usd.high).toFixed(2))
    nmc_low_el.text(parseFloat(data.nmc_usd.low).toFixed(2))
    nmc_average_el.text(parseFloat(data.nmc_usd.average).toFixed(2))

    # Chain to update new transaction
    updateNewTransaction()


  updateExchangeValues = (data) ->
    return if not data or data is {}

    btc_last_usd = parseFloat(data.btc_usd.last) 
    ltc_last_usd = parseFloat(data.ltc_usd.last) 
    nmc_last_usd = parseFloat(data.nmc_usd.last) 

    updateExchangeStats(data)
    updateCharts()


  # Get the latest every second
  setInterval () => 
    $.getJSON '/exchange', updateExchangeValues
  , 5000




