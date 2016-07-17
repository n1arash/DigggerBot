require 'telegram/bot'
require 'ip_info'


TOKEN = "205192920:AAF98akmUeJ4EnR8ALHndtf5tUl9oS7sOcs"
@ip_info= IpInfo::API.new(api_key: "912356c310fe9eadc5ac89d9a73c908077eb2dc06fb72775853f07585fe7f395")

def get_from_address(message)
  message[/([\d.]+|(?:https?:\/\/)?(?:[\w]+\.)?[\w]+\.[\w]+)/]
end

def get_info(address,type)
  return 'Error: Address is invalid ' unless address

  data = ''
  @ip_info.lookup(address,type:type).map do |e|
    data << e.first.to_s.gsub(/_/, ' ').capitalize + ': ' + e.last + "\n"
  end
  data
end

help = """
You Can Use Me By These Commands :
[+] /whois [ip] or [domain]
this is very easy ;-)
"""
puts "Bot Successfully Started ! :) "

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
      when '/start'
        bot.api.send_message(chat_id: message.chat.id, text: "Hello #{message.from.first_name} Welcome To DigggerBot U Can Use /help for commands list")
      when /\/whois [\w\W]+/
        bot.api.send_message(chat_id: message.chat.id, text: get_info(get_from_address(message.text),'city'))
      when '/help'
        bot.api.send_message(chat_id: message.chat.id ,text: help)
      when '/end'
        bot.api.send_message(chat_id: message.chat.id, text: "Good Bye #{message.from.first_name} See You Later My Friend! Come back Again" );
      else
        bot.api.send_message(chat_id: message.chat.id, text: "I Can't Understand Your Command :| ")
    end
  end
end