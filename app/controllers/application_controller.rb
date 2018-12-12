class ApplicationController < ActionController::API

	require 'json'

	def current_doctor
	    @current_doctor ||= session[:current_doctor_id] &&
			Doctor.joins(:users).where( users: { id: session[:current_doctor_id] } ).first
	end

private

    def authenticate_doctor
	token = request.headers['Authorization']
	if current_doctor || (token.present? && (doctor = Doctor.joins(:users).where( users: { login_token: token } ).first))
		session[:token]			= doctor.login_token
		session[:current_doctor_id]	= doctor.id
	else
		render status: :unauthorized
	end
    end

end
