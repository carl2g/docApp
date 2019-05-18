class Api::Doctors::PatientsController < ApplicationController
	before_action :authenticate_user

	def index
		patients = current_doctor.patients.map {|patient| patient.to_json_model }
		render json: { patients: patients.to_json(only: [:id, :email, :first_name, :last_name]) }, status: :ok
	end

end
