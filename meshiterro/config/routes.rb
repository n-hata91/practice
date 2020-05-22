Rails.application.routes.draw do
  root 'post_images#index'
  devise_for :users, controllers:{
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  resources :post_images, only: [:new, :create, :index, :show] do
    resources :post_comments, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
