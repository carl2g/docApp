class Api::Patients::DoctorsController < ApplicationController

	before_action :authenticate_user

	def index
		user_attrs = [:id, :email, :first_name, :last_name]
		doctors = Doctor.all
		render json: doctors.to_json({
			except: [:id, :user_id],
			include: {
				user: { only: user_attrs },
				general_units: { only: [:id, :name] }
			}
		}), status: :ok
	end

	def my_doctors
		user_attrs = [:email, :first_name, :last_name]
		doctors = current_patient.units
		render json: doctors.to_json({
			only: [:id],
			include: {
				general_unit: { only: [:id, :name]},
				doctors: { except: [:user_id], include: { user: {only: user_attrs } } }
			}
		}), status: :ok
	end

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
