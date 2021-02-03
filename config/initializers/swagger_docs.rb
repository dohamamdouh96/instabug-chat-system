class Swagger::Docs::Config
    def self.base_api_controller
      ActionController::API
    end
  end

Swagger::Docs::Config.register_apis({
  "1.0" => {
    :api_file_path => "public/api/v1",
    :base_path => "http://localhost:3001/api",
    :clean_directory => true,
    :base_api_controller => ActionController::API,
    :parent_controller => ApplicationController,
    :attributes => {
      :info => {
        "title" => "Instabug Chat System",
      }
    }
  }
})