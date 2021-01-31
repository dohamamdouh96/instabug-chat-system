Message.__elasticsearch__.create_index!(force: true)

@apllication = Application.create!(name: 'Instabug')

@chat = @apllication.chats.create!(
    number: ApplicationRecord.increment_number(@apllication.chats), 
    application_id: @apllication.id
)

@chat.messages.create!(
    number: ApplicationRecord.increment_number(@chat.messages), 
    body: 'Ruby on Rails',
    chat_id: @chat.id
)