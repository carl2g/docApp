class ApplicationController < ActionController::API

	require 'json'

	def current_doctor
	    @current_doctor ||= session[:current_doctor_id] &&
      		Doctor.find_by(id: session[:current_doctor_id])
  	end

private

    def authenticate_doctor
    	token = request.headers['Authorization']
    	if current_doctor || (token.present? && (doctor = Doctor.find_by_login_token(token)))
    		session[:token] 			= doctor.login_token
    		session[:current_doctor_id] 	= doctor.id
    	else
    		render status: :unauthorized
    	end
    end

end
