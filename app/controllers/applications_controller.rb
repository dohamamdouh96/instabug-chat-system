class ApplicationsController < ApplicationController
    before_action :set_application, only: [:show, :update, :destroy]

    swagger_controller :applications, "Applications"

    swagger_api :index do
      summary "Fetches all User items"
      notes "This lists all the applications"
      response :unauthorized
      response :not_acceptable, "The request you made is not acceptable"
    end

    def index
      @applications = Application.all
      json_response(@applications)
    end
  
    
    swagger_api :create do
      summary "Creates a new Application"
      param :form, :name, :string, :required, "Name"
      response :unauthorized
      response :not_acceptable
    end

    def create
      @application = Application.create!(application_params)
      json_response(@application, :created)
    end
  
    swagger_api :show do
      summary "Fetches a single Application"
      param :path, :token, :string, "Application Token"
      response :ok, "Success", :Application
      response :unauthorized
      response :not_acceptable
      response :not_found
    end

    def show
      json_response(@application)
    end
  
    swagger_api :update do
      summary "Updates an existing Application"
      param :path, :token, :integer, :required, "Application Token"
      param :form, :name, :string, :required, "Name"
      response :unauthorized
      response :not_found
      response :not_acceptable
    end

    def update
      @application.update!(application_params)
      json_response(@application)
    end
  
    swagger_api :destroy do
      summary "Deletes an existing Application"
      param :path, :token, :integer, :required, "Application Token"
      response :unauthorized
      response :not_found
    end

    def destroy
      @application.destroy
      json_response(message: 'Application Deleted Successfully')
    end
  
    private

    def application_params
        params.permit(:name, :token)
    end

    def set_application
        @application = Application.find_by!(token: params[:token])
    end
end
