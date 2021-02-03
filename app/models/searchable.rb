module Searchable
    extend ActiveSupport::Concern
  
    included do
      include Elasticsearch::Model
    #   include Elasticsearch::Model::Callbacks
  
        index_name 'messages'
        document_type 'message'

        settings index: { number_of_shards: 1 } do
            mappings dynamic: 'false' do
              indexes :body, analyzer: 'english', index_options: 'offsets'
            end
          end

        def self.as_indexed_json(options = {})
            self.as_json(
                only: [:number, :body],
                include: {
                    chat: {
                    only: [:number]
                    }
                }
            )
        end 
    end
end