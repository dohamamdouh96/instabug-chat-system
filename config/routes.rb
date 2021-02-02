Rails.application.routes.draw do
    resources :applications, path: '/api/v1/applications', param: :token do
      resources :chats, param: :number do
        resources :messages, param: :number do
          collection do
            get :search
          end
        end
      end
  end
end
