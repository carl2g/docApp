Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 						to: proc { [404, {}, ["Not found."]] }

  namespace :api do
  	post 	'/login', 			to: 'sessions#login'
  	post 	'/logout', 			to: 'sessions#logout'
  	post 	'/doctor/signin', 	to: 'doctors#signin'
    post 	'/patient/signin', 	to: 'patients#signin'
    post  '/patient/add_doctor', to: 'patients#add_doctor'
  end
end
