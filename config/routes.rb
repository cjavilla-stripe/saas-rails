Rails.application.routes.draw do
  devise_for :users
  resource :dashboard
  root to: 'static_pages#root'
end
