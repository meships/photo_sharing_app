Rails.application.routes.draw do
  root'blogs#index'
  resources :favorites, only: [:create, :destroy, :index]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users#, only: [:new, :create, :show, :edit]
  resources :blogs do
    collection do
      post :confirm
    end
  end
  mount LetterOpenerWeb::Engine, at: "/inbox"
end