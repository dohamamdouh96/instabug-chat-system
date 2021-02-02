module Searchable
    extend ActiveSupport::Concern
   
    included do
        include Elasticsearch::Model
        include Elasticsearch::Model::Callbacks
        
        index_name Rails.application.class.parent_name.underscore
        document_type self.name.downcase      

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

        settings index: { number_of_shards: 1 } do
            mapping dynamic: 'true' do
                indexes :body, analyzer: 'english'
            end
        end
    end
end