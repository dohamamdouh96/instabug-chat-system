
@apllication = Application.create!(name: 'Instabug')

@chat = @apllication.chats.create!(
    number: ApplicationRecord.increment_number(Chat.last), 
    application_id: @apllication.id
)

# Message.__elasticsearch__.delete_index!(force: true)
# Message.import force: true
Message.__elasticsearch__.create_index!(force: true)

@chat.messages.create!(
    number: ApplicationRecord.increment_number(Message.last), 
    body: 'Ruby on Rails',
    chat_id: @chat.id
)