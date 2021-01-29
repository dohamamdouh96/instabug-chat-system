class CreateChatJob < ApplicationJob
  queue_as :chat_create

  def perform(application)
    application.chats.create!(
      number: ApplicationRecord.increment_number(application.chats),
      application_id: application.id
    )
  end
end
