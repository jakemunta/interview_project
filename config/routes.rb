Rails.application.routes.draw do
  get 'populations', to: 'populations#index'
  get 'populations/by_year', to: 'populations#show'
  get 'the_logz', to: 'search_histories#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
