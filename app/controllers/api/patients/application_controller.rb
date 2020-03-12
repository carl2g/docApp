class Api::Patients::ApplicationController < ApplicationController
	before_action :authenticate_user, except: [:signin]
	before_action :is_patient?
end
