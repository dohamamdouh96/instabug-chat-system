class Application < ApplicationRecord
    has_many :chats , -> { order(:number) }, dependent: :destroy 
    has_secure_token

    validates_presence_of :name

    def as_json(options = {})     
        super(options.merge({ except: [:id] }))   
    end

    REDIS_COUNTER_KEY = "#{self}:counter"

    def self.increment_count
      RedisClient.redis.incr REDIS_COUNTER_KEY
    end  
end
