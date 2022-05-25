require 'telegram/bot'

STIKERS = [
  'CAACAgIAAx0CVbzQLgADFWFVUi5KR-bNL8qVa8a9jH7ejSX0AAIvAAN5cd4WBMuBddyJMbQhBA',
  'CAACAgIAAx0CVbzQLgADFmFVVgi2boNHRBxpfMVs0HSMwUhCAAIjAAN5cd4W2rS42UaRM5EhBA',
  'CAACAgIAAx0CVbzQLgADH2FVWYN_kK8LrtMKn5mJX3l2B20-AAIuAAN5cd4WSnS803pjo38hBA',
  'CAACAgIAAx0CVbzQLgADGWFVWQABF2ch2Po8nGpLnSODFZI-DAACLAADeXHeFhzvnOoJMqh8IQQ',
  'CAACAgIAAx0CVbzQLgADG2FVWSZKmnfk2FwjTIoChNZHenK_AAISAAN5cd4WveSooL1rRLUhBA',
  'CAACAgIAAx0CVbzQLgADHWFVWVRxsGmTeEhoDZB-hCu15yIqAAIRAAN5cd4WlieYjp-T1kshBA',
  'CAACAgIAAx0CVbzQLgADIWFVWaE6C4t9i6C6AtzNqMBRUwABeQACGAADeXHeFlkmTdPzTa_tIQQ',
  'CAACAgIAAx0CVbzQLgADI2FVWbwuQcKVdb7WW5QaacL7Nsc4AAIzAAN5cd4Wifg5Yb2ZBPAhBA'
]

class WebhooksController < Telegram::Bot::UpdatesController
  def message(message)
    reply = message['reply_to_message']

    if (message['text'] || '')['@HaroldWelcomeBot'] || (reply != nil && reply.dig('from', 'username') === 'HaroldWelcomeBot')
      reply_with :sticker, sticker: STIKERS.sample
    end

    if message['new_chat_members'] && !message['new_chat_members'].empty?
      reply_with :sticker, sticker: 'CAACAgIAAxkBAAMZYVSYYQbI48MxD2QaA94x2ROqgKsAAkIAA2iaXQye3L-VT87R6CEE'
    end

    if message['left_chat_member']
      reply_with :sticker, sticker: 'CAACAgIAAxkBAAEDAAEPYVgHUSxnl9CFCMkdNzRpv1Wqae4AAkQAA3lx3hZio5LFjSdVbiEE'
    end

    if message['text'][' пора ']
      reply_with :sticker, sticker: 'CAACAgIAAxkBAAEUW_1ijls4TbAW4onhIi1kCnANNadP4QACHAADTntVAg7ESRHuvrryJAQ'
      reply_with :sticker, sticker: 'CAACAgIAAxkBAAEUW_9ijls9bgG1dHBOFHxStKnbHzWNaAACHQADTntVArrbH0poFOFxJAQ'
    end
  end
end

bot = Telegram::Bot::Client.new(ENV['TOKEN'])

map '/harold_welcome_bot_webhook' do
  run Telegram::Bot::Middleware.new(bot, WebhooksController)
end

map '/ping' do
  run Proc.new { |env| [200, {"Content-Type" => "text/plain"}, ["pong"]] }
end