class Api::Patients::ApplicationController <  ApplicationController
	before_action :is_patient?, except: [:signin]
end
