var sys = require('sys');
var exec = require('child_process').exec;
function puts(error, stdout, stderr) { sys.puts(stdout); }


setInterval(function() {

  setTimeout(function() {
    exec("curl cryptotrader.co/exchange/btc_usd", puts);
  }, 2000);

  setTimeout(function() {
    exec("curl cryptotrader.co/exchange/ltc_usd", puts);
  }, 4000);

  setTimeout(function() {
    exec("curl cryptotrader.co/exchange/nmc_usd", puts);
  }, 6000);

}, 8000);
