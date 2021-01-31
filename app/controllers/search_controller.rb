class SearchController < ApplicationController
    def index
        response = Message.__elasticsearch__.search(
          query: {
            multi_match: {
              query: params[:query],
              fields: ['body', 'message.body']
            }
          }
        ).results
    
        render json: {
          results: response.results,
          total: response.total
        }
      end
end
