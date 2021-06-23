# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'urls#index'

  resources :urls, only: %i[index create show], param: :url
  get ':short_url', to: 'urls#visit', as: :visit

  namespace :api, defaults: { format: 'json' } do
    resources :urls, only: %i[index]
  end
end
