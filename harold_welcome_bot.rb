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
TOKEN = ENV['TOKEN']

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
  end
end

bot = Telegram::Bot::Client.new(TOKEN)

if ENV['PRODUCTION']
  # webhook mode
  map "/#{TOKEN}" do
    run Telegram::Bot::Middleware.new(bot, WebhooksController)
  end
else
  # poller-mode
  require 'logger'
  logger = Logger.new(STDOUT)
  poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
  poller.start
end