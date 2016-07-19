require 'telegram/bot'
require 'ip_info'
require 'net/dns'

TOKEN = "205192920:AAF98akmUeJ4EnR8ALHndtf5tUl9oS7sOcs"


def get_from_address(message)
  message[/([\d.]+|(?:https?:\/\/)?(?:[\w]+\.)?[\w]+\.[\w]+)/]
end

def dig(address)
  digged = Resolver(address)
end


help = """
You Can Use Me By These Commands :
[+] /dig [ip] or [domain]
this is very easy ;-)
"""
puts "Bot Successfully Started ! :) "

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
      when '/start'
        bot.api.send_message(chat_id: message.chat.id, text: "Hello #{message.from.first_name} Welcome To DigggerBot U Can Use /help for commands list")
      when /\/dig [\w\W]+/
        bot.api.send_message(chat_id: message.chat.id, text: dig(get_from_address(message.text)))
      when '/help'
        bot.api.send_message(chat_id: message.chat.id ,text: help)
      when '/end'
        bot.api.send_message(chat_id: message.chat.id, text: "Good Bye #{message.from.first_name} See You Later My Friend! Come back Again" );
      else
        bot.api.send_message(chat_id: message.chat.id, text: "I Can't Understand Your Command :| ")
    end
  end
end