Rails.application.routes.draw do
  resources :todos
  resources :categories
  resources :transactions

  root "transactions#index"

  get 'statistics', to: 'transactions#statistics', as: 'statistics'
  post '/todos/pending/:id', to: 'todos#pending', as: 'todo_pending'
  post '/todos/inprogress/:id', to: 'todos#inprogress', as: 'todo_inprogress'
  post '/todos/done/:id', to: 'todos#done', as: 'todo_done'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
