class Api::Patients::DoctorsController < ApplicationController

	before_action :authenticate_user

	def index
		user_attrs = [:id, :email, :first_name, :last_name]
		doctors = Doctor.all
		render json: doctors.to_json({
			except: [:user_id],
			include: {
				user: { only: user_attrs },
				general_units: { only: [:id, :name] }
			}
		}), status: :ok
	end

	def my_doctors
		user_attrs = [:id, :email, :first_name, :last_name]
		doctors = current_patient.units
		render json: doctors.to_json({
			only: [:id],
			include: {
				general_unit: { only: [:id, :name]},
				doctors: { except: [:id, :user_id], include: { user: {only: user_attrs } } }
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
			:email,
			:birthdate,
			:civility
		]
	end

	def permited
		params.permit(permited_params)
	end

end
