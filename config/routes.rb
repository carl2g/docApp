Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/'
  mount Rswag::Api::Engine => '/api-docs'
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	root 						to: proc { [404, {}, ["Not found."]] }

	namespace :api do

		namespace :patients do

				############### Patients controller ###############
				post 	'/signin', 				to: 'patients#signin'
				get 	'/',							to: 'patients#index'

				############### General Units controller ###############
				resources :general_units do
					patch '/add_unit', 		to: 'general_units#add_unit'

					collection do
						get 	'/my_units', 	to: 'general_units#my_units'
					end
				end

				############### Units controller ###############
				resources :units do
					get 	'/notes', 			to: 'units#notes'
					post 	'/add_note', 		to: 'units#add_note'
					patch '/add_doctor', 		to: 'units#add_doctor'
					patch '/remove_doctor', 	to: 'units#remove_doctor'

					collection do
						get '/my_units', 		to: 'units#my_units'
					end
				end


				############### Doctors controller ###############
				resources :doctors do

					collection do
						get '/my_doctors', 	to: 'doctors#my_doctors'
					end
				end

				############### Notes controller ###############
				resources :notes do

				end
		end

		namespace :doctors do
			post 	'/signin', 	to: 'doctors#signin'
			patch '/add_unit',	to: 'doctors#add_unit'
			patch '/remove_unit',	to: 'doctors#remove_unit'

			resources :patients do

			end

		end

		post 	'/login', 						to: 'sessions#login'
		post 	'/logout', 						to: 'sessions#logout'
		get 	'/available_units', 				to: 'general_units#index'

	end
end
