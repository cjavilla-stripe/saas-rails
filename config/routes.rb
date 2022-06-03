Rails.application.routes.draw do
  get 'pricings/show'
  devise_for :users
  resource :dashboard
  root to: 'static_pages#root'
  resource :pricing
  resource :checkout

end
