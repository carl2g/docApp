class ApplicationController < ActionController::API
	before_action :authenticate_user, except: [:signin, :login]
	
	def current_user
	    @current_user ||= session[:current_user_id] && User.find(session[:current_user_id])
	end

	def current_patient
		@current_patient ||= Patient.find_by(user_id: current_user.id) if current_user
	end

	def current_doctor
		@current_doctor ||= Doctor.find_by(user_id: current_user.id) if current_user
	end

	def is_doctor?
		if current_doctor.nil?
			render status: :unauthorized
		end
	end

	def is_patient?
		if current_patient.nil?
			render status: :unauthorized
		end
	end

private

    def authenticate_user
		token = request.headers['Authorization']
		if current_user || (token.present? && (user = User.find_by(login_token: token)))
			session[:login_token]		= user.login_token
			session[:current_user_id]	= user.id
		else
			render status: :unauthorized
		end
    end

end
