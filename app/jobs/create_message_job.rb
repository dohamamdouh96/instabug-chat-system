class CreateMessageJob < ApplicationJob
  queue_as :default

  def perform(chat)
    chat.messages.create!(
      number: ApplicationRecord.increment_number(chat.messages),
      body: params[:body], 
      chat_id: chat.id
    )
  end
end
