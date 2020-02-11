Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/'
  mount Rswag::Api::Engine => '/api-docs'
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	root 						to: proc { [404, {}, ["Not found."]] }

	namespace :api do

		namespace :patients do

				############### Patients controller ###############
				post 	'/signin', 				to: 'patients#signin'

				############### General Units controller ###############
				resources :general_units do
					patch '/add_unit', 		to: 'general_units#add_unit'
				end

				############### Units controller ###############
				resources :units do
					get 	'/notes', 			to: 'units#notes'
					post 	'/add_note', 		to: 'units#add_note'
					patch 	'/add_doctor', 		to: 'units#add_doctor'
					patch 	'/remove_doctor', 	to: 'units#remove_doctor'
					patch 	'/change_filter', 	to: 'units#change_filter'
					post 	'/share_notes', 	to: 'units#share_notes'

					collection do
						get '/my_units', 		to: 'units#my_units'
					end
				end


				############### Doctors controller ###############
				resources :doctors do

					collection do
						get '/my_doctors', 	to: 'doctors#my_doctors'
						get '/profile',	to: 'doctors#profile'
					end
				end

				############### Notes controller ###############
				resources :notes do
				end

				############### Profile controller ###############
				resources :profiles do
					collection do
						post '/update', to: 'profiles#update'
						post '/change_password', to: 'profiles#change_password'
						post '/check_password', to: 'profiles#check_password'
					end
				end
		end


		namespace :doctors do

			post 	'/signin', 		to: 'doctors#signin'
			patch 	'/add_unit',	to: 'doctors#add_unit'
			patch 	'/remove_unit',	to: 'doctors#remove_unit'

			resources :patients do
				collection do
					get '/profile',	to: 'patients#profile'
				end
			end

			resources :profiles do
				collection do
					post '/update', to: 'profiles#update'
					post '/change_password', to: 'profiles#change_password'
					post '/check_password', to: 'profiles#check_password'
				end
      		end

			resources :notes do
			end

		end

		namespace :admins do

			resources :notes do
			end

			resources :patients do
				collection do
					post '/update', to: 'patients#update'
					post '/delete', to: 'patients#delete'
					get  '/list', to: 'patients#index'
				end
			end

			resources :doctors do
				collection do
					post '/update', to: 'doctors#update'
					post '/delete', to: 'doctors#delete'
					get  '/list', to: 'doctors#index'
				end
			end

		end

		post 	'/login', 						to: 'sessions#login'
		post 	'/logout', 						to: 'sessions#logout'
		post	'/patient_email_confirm', 		to: 'sessions#patient_email_confirm'
	end
end
