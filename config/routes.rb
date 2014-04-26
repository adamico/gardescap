Gardescap::Application.routes.draw do
  devise_for :users

  delete 'empty_activity', to: 'activities#empty'
  get 'choix', to: 'periods#show'
  get 'tableau_actuel', to: 'periods#show'
  resources :periods, path: '/tableaux' do
    get :populate, on: :member
  end
  get 'tags', to: 'gardes#tags', as: 'gardes_tags'
  match 'gardes/toggle_holiday', to: 'gardes#mass_toggle_holiday', as: 'mass_toggle_holiday_gardes', via: [:put, :patch]
  resources :gardes
  resources :assignments
  resources :activities
  get 'stats', to: 'home#stats'
  root to: 'home#index'
end
