Wopu::Application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :results

  resources :categories

  resources :available_tags

  resources :tags

  resources :donations do
    post 'accept' => 'donations#accept'
    post 'reject' => 'donations#reject'
  end

  resources :users

  resources :nonprofits do
    resources :needs do
      post 'mark_solved' => 'needs#mark_solved'
    end
  end

  get 'admin' => 'admin#index'

  root 'home#index'
end
