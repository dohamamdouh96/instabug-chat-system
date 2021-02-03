class ChatsController < ApplicationController
    before_action :set_application
    before_action :set_chat, only: [:show, :update, :destroy]

    swagger_controller :chats, "Chats"

    swagger_api :index do
      summary "Fetches all Application chats"
      notes "This lists all the Application chats"
      param :path, :application_token, :string, :required, "Application Token"
      response :unauthorized
      response :not_acceptable, "The request you made is not acceptable"
    end

    def index
      json_response(@application.chats)
    end
  
    swagger_api :create do
      summary "Creates a new Chat"
      param :path, :application_token, :string, :required, "Application Token"
      response :unauthorized
      response :not_acceptable
    end

    def create
        @chat = @application.chats.create!(
          number: ApplicationRecord.increment_number(Chat.last),
          application_id: @application.id
        )
        json_response(@chat, :created)
    end
  
    swagger_api :show do
      summary "Fetches a single Chat"
      param :path, :application_token, :string, :required, "Application Token"
      param :path, :number, :integer, :required, "Chat Number"
      response :ok, "Success", :Chat
      response :unauthorized
      response :not_acceptable
      response :not_found
    end

    def show
      json_response(@chat)
    end
  
    swagger_api :destroy do
      summary "Deletes an existing Chat"
      param :path, :token, :integer, :required, "Application Token"
      param :path, :number, :integer, :required, "Chat Number"
      response :unauthorized
      response :not_found
    end

    def destroy
      @chat.destroy
      json_response(message: 'Chat Deleted Successfully')
    end
  
    private

    def set_application
      @application = Application.find_by!(token: params[:application_token])
    end

    def set_chat
      @chat = @application.chats.find_by!(number: params[:number]) if @application
    end
end
