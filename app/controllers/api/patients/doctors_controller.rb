class Api::Patients::DoctorsController < ApplicationController

	before_action :authenticate_user

	def index
		user_attrs = [:email, :first_name, :last_name]
		doctors = Doctor.all
		render json: doctors.to_json({
			only: [:id],
			include: {
				user: { only: user_attrs }
			}
		}), status: :ok
	end

	def my_doctors
		user_attrs = [:email, :first_name, :last_name]
		doctors = current_patient.doctors
		render json: doctors.to_json({
			only: [:id],
			include: {
				user: { only: user_attrs }
			}
		}), status: :ok
	end

	# {id: 2, user: { id: 3}}.to_h.to_json(query)
	# JSON.parse('{"include": ["user", {"units": { "include":  "doctor" }} ]}', {symbolize_names: true})

private

	def permited_params
		[
			:first_name,
			:last_name,
			:password,
			:phone_number,
			:email
		]
	end

	def permited
		params.permit(permited_params)
	end

end
