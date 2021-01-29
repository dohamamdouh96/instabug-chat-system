class ApplicationsController < ApplicationController
    before_action :set_application, only: [:show, :update, :destroy]

    def index
      @applications = Application.all
      json_response(@applications)
    end
  
    def create
      @application = Application.create!(application_params)
      json_response(@application, :created)
    end
  
    def show
      json_response(@application)
    end
  
    def update
      @application.update!(application_params)
      json_response(@application)
    end
  
    def destroy
      @application.destroy!
      head :no_content
    end
  
    private

    def application_params
        params.permit(:name, :token)
    end

    def set_application
        @application = Application.find_by!(token: params[:token])
    end
end
