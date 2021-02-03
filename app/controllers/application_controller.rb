class ApplicationController < ActionController::API
    include Response
    include ExceptionHandler
    include Swagger::Docs::Methods
end
