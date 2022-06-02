Rails.application.routes.draw do
  get 'dashboards/show'
  devise_for :users
  resource :dashboard
end
