class MessagesController < ApplicationController
    before_action :set_chat
    before_action :set_message, only: [:show, :update, :destroy]

    def index
      if (params[:search])
        @response = Message.__elasticsearch__.search(
          query: {
            multi_match: {
              query: params[:search],
              fields: ['body']
            }
          }
        ).results
    
        json_response(@response.results)
      else
        json_response(@chat.messages)
      end
    end
  
    def create
      @message = @chat.messages.create!(
        number: ApplicationRecord.increment_number(Message.last),
        body: params[:body], 
        chat_id: @chat.id
      )
      json_response(@message, :created)
    end
  
    def show
      json_response(@message)
    end
  
    def update
      @message.update!(message_params)
      json_response(@message)
    end
  
    def destroy
        @message.destroy
        head:no_content
    end

    def search    
      if params[:body]
        @messages = @chat.messages.search(params[:body])
        json_response(@messages)
      else
        json_response(@chat.messages)
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
