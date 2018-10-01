Rails.application.routes.draw do
  resources :companies
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    invitations: "invitations"
	}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  devise_scope :user do
		post '/sign_up_validation', to: 'users/omniauth_callbacks#sign_up_validation'
	end

  resources :companies do
    resources :company_users, path: :users, module: :companies
  end
end
