class ChatsController < ApplicationController
    before_action :set_application
    before_action :set_chat, only: [:show, :update, :destroy]

    def index
      json_response(@application.chats)
    end
  
    def create
        @chat = @application.chats.create!(
          number: ApplicationRecord.increment_number(Chat.last),
          application_id: @application.id
        )
        json_response(@chat, :created)
    end
  
    def show
      json_response(@chat)
    end
  
    def update
      @chat.update!(chat_params)
      json_response(@chat)
    end
  
    def destroy
      @chat.destroy!
      head :no_content
    end
  
    private

    def chat_params
        params.permit(:number)
    end

    def set_application
      @application = Application.find_by!(token: params[:application_token])
    end

    def set_chat
      @chat = @application.chats.find_by!(number: params[:number]) if @application
    end
end
