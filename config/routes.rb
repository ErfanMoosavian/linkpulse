Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root "links#index"

  get "/locale/:locale", to: "locales#update", as: :switch_locale, constraints: { locale: /en|fa/ }

  namespace :api do
    namespace :v1 do
      resources :links, only: [ :index, :show, :create, :destroy ]
    end
  end

  resources :links, only: [ :index, :create, :show, :destroy ]
  get "/:short_code", to: "redirects#show", as: :short, constraints: { short_code: /[a-zA-Z0-9_-]{4,15}/ }
end
