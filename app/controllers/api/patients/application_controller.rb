class Api::Patients::ApplicationController <  ActionController::API
	before_action :is_patient?, except: [:signin]
end
