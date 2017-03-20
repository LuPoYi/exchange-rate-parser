require 'rubygems'
require 'yaml'
require 'json'
require 'open-uri'
require 'redis'
require 'rest-client'
require 'rufus-scheduler'
require 'nokogiri'

require_relative 'lib/main.rb'
require_relative 'lib/esun.rb'
require_relative 'lib/bank_of_taiwan.rb'
require_relative 'lib/bitoex.rb'
require_relative 'lib/okcoin.rb'
require_relative 'lib/telegram_bot.rb'

$settings = YAML.load_file('./config.yml')
$redis = Redis.new($settings[:redis])
$ssdb  = Redis.new($settings[:ssdb ])

# Esun.start!
# BankOfTaiwan.start!
# Bitoex.start!
Main.start!
