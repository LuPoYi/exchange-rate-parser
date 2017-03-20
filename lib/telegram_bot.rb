require 'telegram/bot'

class TelegramBot
  def self.start!
    Telegram::Bot::Client.run($settings[:telegram][:token]) do |bot|
      bot.listen do |message|
        case message.text
        when '/help'
          ans = "asfasdfsdfdsfsdfdsfds"
          bot.api.send_message(chat_id: message.chat.id, text: ans)
        when /\A(\/notice)/
          # add chat_id to redis
          chat_ids = $redis.lrange('chat_ids', 0, -1)        
          if chat_ids.index(message.chat.id.to_s)
            bot.api.send_message(chat_id: message.chat.id, text: "已新增")
          else
            $redis.lpush('chat_ids', message.chat.id) 
            bot.api.send_message(chat_id: message.chat.id, text: "新增完成")
          end
        end
      end
    end
  end

  def self.send_message(text)
    chat_ids = $redis.lrange('chat_ids', 0, -1)
    chat_ids.each do |chat_id|
      begin
        RestClient.post("https://api.telegram.org/bot#{$settings[:telegram][:token]}/sendMessage" , {
          :chat_id => chat_id,
          :text => text
        })
      rescue Exception => e 
        puts "Telegram通知有誤 #{e.message}"
      end
    end
  end
end
