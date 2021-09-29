require 'telegram/bot'

$stdout.reopen("#{__dir__}/harold_welcome_bot.log", 'a')
$stdout.sync = true

puts "[#{Time.now}] Bot started"
Telegram::Bot::Client.run(ENV['TOKEN']) do |bot|
  bot.listen do |message|
    unless message.new_chat_members.empty?
      message.new_chat_members.each do |user|
        bot.api.send_sticker(
          chat_id: message.chat.id,
          reply_to_message_id: message.message_id,
          sticker: 'CAACAgIAAxkBAAMZYVSYYQbI48MxD2QaA94x2ROqgKsAAkIAA2iaXQye3L-VT87R6CEE'
        )
      end
    end
  end
end