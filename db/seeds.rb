require 'elasticsearch'

@apllication = Application.create!(name: 'Instabug')

@chat = @apllication.chats.create!(
    number: ApplicationRecord.increment_number(Chat.last), 
    application_id: @apllication.id
)

# Message.__elasticsearch__.create_index! force: true
# Message.__elasticsearch__.refresh_index!

client = Elasticsearch::Client.new log: true

@chat.messages.__elasticsearch__.client.cluster.health

@chat.messages.__elasticsearch__.client.indices.delete index: @chat.messages.index_name rescue nil
@chat.messages.__elasticsearch__.client.index(index: @chat.messages.index_name, type: @chat.messages.document_type, 
    body: { settings: @chat.messages.settings.to_hash, mappings: @chat.messages.mappings.to_hash})

client.indices.refresh(index: @chat.messages.index_name)

@chat.messages.create!(
    number: ApplicationRecord.increment_number(Message.last), 
    body: 'Ruby on Rails',
    chat_id: @chat.id
)

