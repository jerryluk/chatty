class MessageNotifier
  include Sidekiq::Worker

  sidekiq_options :queue => :high

  def perform(message_id)
    message = Message.find(message_id)
    message.notify!
  end
end
