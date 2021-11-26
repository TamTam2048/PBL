# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :users
  resources :products do
    resources :reviews
  end
  resources :orders, only: %i[create update destroy]
  resources :line_items, only: %i[create update destroy]
  resources :checkouts, param: :slug
  resource  :cart, only: [:show]
end
