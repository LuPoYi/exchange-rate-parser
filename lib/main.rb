class Main
  def self.start!
    scheduler = Rufus::Scheduler.new

    scheduler.every '3s' do
      puts 'Hello... Rufus'
      TelegramBot.send_message('adfsdfsdfdsf')
    end

    scheduler.every '1h' do
      # call various rate api, save rate
    end
    scheduler.cron '00 13 * * *' do
      # send telegram msg to user
      # rate list... 
    end
    scheduler.join

    TelegramBot.start!
  end
end

