class Application < ApplicationRecord
    has_many :chats, dependent: :destroy 
    has_secure_token

    validates_presence_of :name

    def as_json(options = {})     
        super(options.merge({ except: [:id] }))   
    end
end
