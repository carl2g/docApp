Rails.application.routes.draw do
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	root 						to: proc { [404, {}, ["Not found."]] }

	namespace :api do

		resources :doctors do
			collection do
				post 	'/signin', 	to: 'doctors#signin'
			end
		end

		resources :patients do
			collection do
				patch	'/remove_module/:id',		to: 'patients#remove_module'
				post 	'/signin', 				to: 'patients#signin'
				get 	'/modules',				to: 'patients#modules'
				patch '/add_module/:id', 		to: 'patients#add_module'
				patch '/add_doctor/:id', 		to: 'patients#add_doctor'
				get 	'/doctors', 			to: 'patients#doctors'
			end
		end

		resources :notes do

		end

		post 	'/login', 						to: 'sessions#login'
		post 	'/logout', 						to: 'sessions#logout'
		get 	'/modules', 					to: 'generic_modules#index'
		get 	'/modules', 					to: 'generic_modules#index'
	end
end
