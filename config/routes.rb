Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	root 						to: proc { [404, {}, ["Not found."]] }

	namespace :api do

		namespace :patients do

				############### Patients controller ###############
				post 	'/signin', 				to: 'patients#signin'

				############### Modules controller ###############
				resources :generic_modules, path: 'modules' do
					get 	'/my_modules', 			to: 'generic_modules#my_modules'
					patch	'/remove_module',			to: 'generic_modules#remove_module'
					patch '/add_module', 			to: 'generic_modules#add_module'
				end


				############### Doctors controller ###############
				resources :doctors do
					patch '/add_doctor', 			to: 'doctors#add_doctor'
					patch '/remove_doctor', 		to: 'doctors#remove_doctor'
				end
				get '/my_doctors', 				to: 'doctors#my_doctors'

				############### Notes controller ###############
				resources :notes do

				end
		end

		namespace :doctors do
			post 	'/signin', 	to: 'doctors#signin'

		end

		post 	'/login', 						to: 'sessions#login'
		post 	'/logout', 						to: 'sessions#logout'
		get 	'/modules', 					to: 'generic_modules#index'

	end
end
