Rails.application.routes.draw do
  resources :projects

  root 'projects#index'

  get 'search' => 'projects#search'

  get 'calendar' => 'calendar#index'
end
