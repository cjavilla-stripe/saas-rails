Rails.application.routes.draw do
  devise_for :users
  resource :dashboard
  root to: 'static_pages#root'
  resource :pricing
  get '/custom-pricing', to: 'pricings#custom'
  resource :checkout
  resource :billing
end
