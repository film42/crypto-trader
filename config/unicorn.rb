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
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 15
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end