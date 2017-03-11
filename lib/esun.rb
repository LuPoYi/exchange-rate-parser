require 'nokogiri'
require 'open-uri'

module Esun
  def self.start!
    ans = []
    currencies = ['USD', 'JPY', 'EUR', 'AUD', 'GBP']
    
    url = "https://www.esunbank.com.tw/bank/personal/deposit/rate/forex/foreign-exchange-rates"
    puts "url: #{url}"
    doc = Nokogiri::HTML(open(URI.encode(url)))

    #rate_set = doc.search('#inteTable1 tbody tr td.itemTtitle')
    rate_set = doc.search('#inteTable1  tr:not(.titleRow)')
    rate_set.each do |a|
      # 先判斷該行幣別
      currency = nil
      currency_info = a.search('td.itemTtitle a')[0].content # 美元(USD)
      currencies.each do |cur|
        if currency_info.include? cur
          currency = cur
          break
        end
      end
      
      if currency
        spot_selling = a.search('td.odd')[0].content
        spot_buying = a.search('td.even')[0].content
        cash_selling = a.search('td.odd')[1].content
        cash_buying = a.search('td.even')[1].content
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

=begin
    box_set.each do |a|
      av_title = a.search('.photo-frame img')[0]['title']
      av_img_link = a.search('.photo-frame img')[0]['src'].gsub(/s.jpg\z/ , 'l.jpg') # 小圖轉大圖

      av_id = a.search('.photo-info span date')[0].content
      av_created_at = a.search('.photo-info span date')[1].content

      ans << "#{av_id}\n#{av_title}\n#{av_created_at}\n#{av_img_link}"
    end
=end
#inteTable1 tbody tr td.itemTtitle