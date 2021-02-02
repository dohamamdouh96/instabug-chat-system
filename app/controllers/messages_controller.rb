class MessagesController < ApplicationController
    before_action :set_chat
    before_action :set_message, only: [:show, :update, :destroy]

    swagger_controller :messages, "Messages"

    swagger_api :index do
      summary "Fetches all Chats messages"
      notes "This lists all the Chats messages"
      param :path, :application_token, :string, :required, "Application Token"
      param :path, :chat_number, :integer, :required, "Chat Number"
      response :unauthorized
      response :not_acceptable, "The request you made is not acceptable"
    end

    def index
        json_response(@chat.messages)
    end
  
    swagger_api :create do
      summary "Creates a new Message"
      param :path, :application_token, :string, :required, "Application Token"
      param :path, :chat_number, :integer, :required, "Chat Number"
      param :form, :body, :text, :required, "Body"
      response :unauthorized
      response :not_acceptable
    end

    def create
      @message = @chat.messages.create!(
        number: ApplicationRecord.increment_number(Message.last),
        body: params[:body], 
        chat_id: @chat.id
      )
      json_response(@message, :created)
    end
  
    swagger_api :show do
      summary "Fetches a single Message"
      param :path, :application_token, :string, :required, "Application Token"
      param :path, :chat_number, :integer, :required, "Chat Number"
      param :path, :number, :integer, :required, "Message Number"
      response :ok, "Success", :Message
      response :unauthorized
      response :not_acceptable
      response :not_found
    end

    def show
      json_response(@message)
    end
  
    swagger_api :destroy do
      summary "Deletes an existing Message"
      param :path, :token, :integer, :required, "Application Token"
      param :path, :chat_number, :integer, :required, "Chat Number"
      param :path, :number, :integer, :required, "Message Number"
      response :unauthorized
      response :not_found
    end

    def destroy
      @message.destroy
      json_response(message: 'Message Deleted Successfully')
    end

    swagger_api :search do
      summary "Search Message's body"
      param :path, :application_token, :string, :required, "Application Token"
      param :path, :chat_number, :integer, :required, "Chat Number"
      param :form, :body, :text, :required, "Body"
      response :unauthorized
      response :not_acceptable
    end

    def search
        if (params[:body])
          @messages = @chat.messages.__elasticsearch__.search(
            query: {
              multi_match: {
                query: params[:body],
                fields: ['body']
              }
            }
          ).results

          json_response(messages: @messages.results, total: @messages.total.value)
        else
          json_response(messages: @chat.messages, total: @chat.messages.size)
        end
    end
   
    private

    def message_params
        params.permit(:body)
    end

    def set_chat
      @chat = Chat.find_by!(number: params[:chat_number])
    end

    def set_message
        @message = @chat.messages.find_by!(number: params[:number]) if @chat
    end

 
end
