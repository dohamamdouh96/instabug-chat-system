# README

Instabug Back End Challenge

* Ruby version: 2.7.0
* Ruby on Rails version: 5.2.4

Installation Steps: 

* Clone or download the repo through https://github.com/dohamamdouh96/instabug-chat-system.git
* Open your favorite terminal and cd instabug-chat-system
* Run command "docker-compose up", this will build:  
  - Mysql
  - Redis
  - Elasticsearch
  - Rails App

* Open Postman or your favorite platform for testing APIs.. and you are ready to go!

# Endpoints 
  - Base Path: http://localhost:3001/api/v1

  Applications 
  
    Index
    - Description: Fetch all the application
    - Method:GET /applications
    
    Create 
    - Description: Creates a new Application
    - Method: POST /applications
    - param: name in form 
    
    Show
    - Description: Fetches a single Application
    - Method: GET /applications/:token
    - param: token in path 

    Update
    - Description: Updates an existing Application
    - Method: PUT /applications/:token
    - param: token in path
    - param: name in form
    
    Delete
    - Description: Deletes an existing Application
    - Method: DELETE /applications/:token
    - param: token in path

***********************************************************

 Chats 
    
    Index
    - Description: Fetch all the application's chats
    - Method:GET /applications/:application_token/chats
    - param: application token in path
    - param: chat number in path
    
    Create
    - Description: Creates a new Chat
    - Method: POST /applications/:application_token/chats
    - param: application token in path 
    
    Show
    - Description: Fetches a single Chat
    - Method: GET /applications/:application_token/chats/:number
    - param: application token in path
    - param: chat number in path

    Delete
    - Description: Deletes an existing Chat
    - Method: DELETE /applications/:application_token/chats/:number
    - param: application token in path
    - param: chat number in path


***********************************************************

 Messages 
    
    Index
    - Description: Fetch all the chat's messages
    - Method:GET /applications/:application_token/chats/:chat_number/messages
    - param: application token in path
    - param: chat number in path
    
    Create
    - Description: Creates a new Message
    - Method: POST /applications/:application_token/chats/:chat_number/messages
    - param: application token in path
    - param: chat number in path
    
    Show
    - Description: Fetches a single message
    - Method: GET /applications/:application_token/chats/:chat_number/messages/:number
    - param: application token in path
    - param: chat number in path
    - param: message number in path

    Delete
    - Description: Deletes an existing message
    - Method: DELETE /applications/:application_token/chats/:chat_number/messages/:number
    - param: application token in path
    - param: chat number in path
    - param: message number in path
    
    Search
    - Description: Search In Messages' bodies
    - Method: DELETE /applications/:application_token/chats/:chat_number/messages/search
    - param: application token in path
    - param: chat number in path
    - param: body in form

* You can also run the test suite inside the app container with command "bundle exec rspec"

And that's it!
