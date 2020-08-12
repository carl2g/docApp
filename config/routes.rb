Rails.application.routes.draw do
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	root 						to: proc { [404, {}, ["Not found."]] }

	namespace :api do

		namespace :patients do

				############### Patients controller ###############
				post 	'/signin', 				to: 'patients#signin'

				############### General Units controller ###############
				resources :general_units do
					patch '/add', 		to: 'general_units#add'
					get '/doctors',	to: 'general_units#doctors'
					get '/info',	to: 'general_units#info'
					get '/note_model',	to: 'general_units#note_model'
					get '/get_note_fileds', to: 'general_units#get_note_fileds'
				end

				############### Units controller ###############
				resources :units do
					get 	'/notes', 					to: 'units#notes'
					post 	'/add_note', 				to: 'units#add_note'
					patch 	'/add_doctor', 				to: 'units#add_doctor'
					patch 	'/remove_doctor', 			to: 'units#remove_doctor'
					patch 	'/change_filter', 			to: 'units#change_filter'
					post 	'/share_notes', 			to: 'units#share_notes'
					get 	'/doctors', 				to: 'units#doctors'
					get 	'/get_filter', 				to: 'units#get_filter'
					get 	'/get_general_unit_id', 	to: 'units#get_general_unit_id'
				end


				############### Doctors controller ###############
				resources :doctors do
					get '/profile',	to: 'doctors#profile'
					collection do
						get '/my_doctors', 	to: 'doctors#my_doctors'
					end
				end

				############### Notes controller ###############
				resources :notes do
					get 	'/doctors', to:  'notes#doctors'
					patch 	'/unshare', to: 'notes#unshare'
					collection do
						get '/notes_by_date_interval', to: 'notes#notes_by_date_interval'
					end
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

			resources :general_units do
				patch '/add',	to: 'general_units#add'
				patch '/remove',	to: 'general_units#remove'
				get '/info',	to: 'general_units#info'
			end

			resources :units do
			end

			resources :patients do
				get '/profile',	to: 'patients#profile'
				get '/units', to: 'patients#units'
			end

			resources :profiles do
				collection do
					post '/update', to: 'profiles#update'
					post '/change_password', to: 'profiles#change_password'
					post '/check_password', to: 'profiles#check_password'
				end
      		end

			resources :notes do
				collection do
					get '/notes_by_date_interval', to: 'notes#notes_by_date_interval'
				end
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
		post	'/send_mail_from_doctor', 		to: 'mail#send_mail_from_doctor'

	end
end
