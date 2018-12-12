Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 						to: proc { [404, {}, ["Not found."]] }
  
  namespace :api do
  	post 	'/login', 		to: 'doctors#login'
  	post 	'/logout', 		to: 'doctors#logout'
  	post 	'/signin', 		to: 'doctors#signin'
  end
end
