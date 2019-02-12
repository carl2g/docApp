Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 						to: proc { [404, {}, ["Not found."]] }

  namespace :api do
  	resources :doctors
  	post 	'/login', 				to: 'sessions#login'
  	post 	'/logout', 				to: 'sessions#logout'
  	post 	'/doctor/signin', 		to: 'doctors#signin'
  	post 	'/patient/signin', 		to: 'patients#signin'
  	get '/modules', 				to: 'd_modules#index'
  	post '/patient/remove_module/:id',	to: 'patients#remove_module'
  	get '/patient/modules',		to: 'patients#modules'
  	get '/modules', 				to: 'd_modules#index'
  	post '/patient/add_module/:id', 		to: 'patients#add_module'
    	post  '/patient/add_doctor/:id', 		to: 'patients#add_doctor'
  end
end
