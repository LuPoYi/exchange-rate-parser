require 'nokogiri'
require 'open-uri'

module BankOfTaiwan
  def self.start!
    ans = []
    currencies = ['USD', 'JPY', 'EUR', 'AUD', 'GBP']
    
    url = "http://rate.bot.com.tw/xrt?Lang=zh-TW"
    puts "url: #{url}"
    doc = Nokogiri::HTML(open(URI.encode(url)))

    #rate_set = doc.search('#inteTable1 tbody tr td.itemTtitle')
    rate_set = doc.search('table.table.table-striped.table-bordered.table-condensed.table-hover tbody tr')
    rate_set.each do |a|
      # 先判斷該行幣別

      currency = nil
      currency_info = a.search('td.currency div.print_hide')[0].content # 美元(USD)

      currencies.each do |cur|
        if currency_info.include? cur
          currency = cur
          break
        end
      end
      
      if currency
        spot_selling = a.search('td.rate-content-sight')[1].content
        spot_buying = a.search('td.rate-content-sight')[0].content
        cash_selling = a.search('td.rate-content-cash')[1].content
        cash_buying = a.search('td.rate-content-cash')[0].content
        puts "\ncurrency #{currency}"
        puts "spot_selling #{spot_selling}"
        puts "spot_buying #{spot_buying}"
        puts "cash_selling #{cash_selling}"
        puts "cash_buying #{cash_buying}"
      end
    end
    

    return rate_set
  end
end
