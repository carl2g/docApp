Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
  	root 					to: 'users#login'
  	get 	'/login', 		to: 'users#login'
  	get 	'/logout', 		to: 'users#logout'
  	post 	'/signin', 		to: 'users#signin'
  end
end
