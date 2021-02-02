Swagger::Docs::Config.register_apis({
  "1.0" => {
    :api_extension_type => :json,
    :api_file_path => "public/apidocs",
    :base_path => "http://localhost:3001",
    :clean_directory => true,
    :attributes => {
      :info => {
        "title" => "Instabug Chat System",
        "description" => "Rails API documention with Swagger UI.",
        "termsOfServiceUrl" => "",
        "contact" => ""
       }
     }
  }
})