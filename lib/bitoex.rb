require 'json'
require 'open-uri'

module Bitoex
  def self.start!
    url = "https://www.bitoex.com/sync/dashboard_fixed/#{(Time.now.to_f * 1000).to_i}"
    puts "url: #{url}"
    data = open(url).read
    data = JSON.parse(data)  # ["32,363", "30,328", 1489892414069, 1489892357412]
    puts "buying  #{data[0]}"
    puts "selling #{data[1]}"
  end
end