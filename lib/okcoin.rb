require 'json'
require 'open-uri'

module Okcoin
  def self.start!
    url = "https://www.okcoin.com/api/v1/ticker.do?symbol=btc_usd"
    puts "url: #{url}"
    data = open(url).read
    data = JSON.parse(data)  # {"date":"1489893590","ticker":{"buy":"1013.12","high":"1106.05","last":"1015.0","low":"953.0","sell":"1015.45","vol":"9172.933"}}
    puts "buying  #{data['ticker']['buy']}"
    puts "selling #{data['ticker']['sell']}"
  end
end