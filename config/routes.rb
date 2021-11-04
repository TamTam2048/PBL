Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth'}
  root "home#index"
end
