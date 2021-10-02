require 'telegram/bot'

$stdout.reopen("#{__dir__}/harold_welcome_bot.log", 'a')
$stdout.sync = true

reply_stikers = [
  'CAACAgIAAx0CVbzQLgADFWFVUi5KR-bNL8qVa8a9jH7ejSX0AAIvAAN5cd4WBMuBddyJMbQhBA',
  'CAACAgIAAx0CVbzQLgADFmFVVgi2boNHRBxpfMVs0HSMwUhCAAIjAAN5cd4W2rS42UaRM5EhBA',
  'CAACAgIAAx0CVbzQLgADH2FVWYN_kK8LrtMKn5mJX3l2B20-AAIuAAN5cd4WSnS803pjo38hBA',
  'CAACAgIAAx0CVbzQLgADGWFVWQABF2ch2Po8nGpLnSODFZI-DAACLAADeXHeFhzvnOoJMqh8IQQ',
  'CAACAgIAAx0CVbzQLgADG2FVWSZKmnfk2FwjTIoChNZHenK_AAISAAN5cd4WveSooL1rRLUhBA',
  'CAACAgIAAx0CVbzQLgADHWFVWVRxsGmTeEhoDZB-hCu15yIqAAIRAAN5cd4WlieYjp-T1kshBA',
  'CAACAgIAAx0CVbzQLgADIWFVWaE6C4t9i6C6AtzNqMBRUwABeQACGAADeXHeFlkmTdPzTa_tIQQ',
  'CAACAgIAAx0CVbzQLgADI2FVWbwuQcKVdb7WW5QaacL7Nsc4AAIzAAN5cd4Wifg5Yb2ZBPAhBA'
]

puts "[#{Time.now}] Bot started"
Telegram::Bot::Client.run(ENV['TOKEN']) do |bot|
  bot.listen do |message|
    case message
    when Telegram::Bot::Types::Message

      reply = message.reply_to_message
      if (message.text || '')['@HaroldWelcomeBot'] || (reply != nil && reply.from.username === 'HaroldWelcomeBot')
        bot.api.send_sticker(
          chat_id: message.chat.id,
          reply_to_message_id: message.message_id,
          sticker: reply_stikers.sample
        )
      end

      unless message.new_chat_members.empty?
        bot.api.send_sticker(
          chat_id: message.chat.id,
          reply_to_message_id: message.message_id,
          sticker: 'CAACAgIAAxkBAAMZYVSYYQbI48MxD2QaA94x2ROqgKsAAkIAA2iaXQye3L-VT87R6CEE'
        )
      end

      if message.left_chat_member
        bot.api.send_sticker(
          chat_id: message.chat.id,
          reply_to_message_id: message.message_id,
          sticker: 'CAACAgIAAxkBAAEDAAEPYVgHUSxnl9CFCMkdNzRpv1Wqae4AAkQAA3lx3hZio5LFjSdVbiEE'
        )
      end

    end
  end
end