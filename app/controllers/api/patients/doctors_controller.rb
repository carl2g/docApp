class Api::Patients::DoctorsController < ApplicationController

	before_action :authenticate_user

	def index
		user_attrs = [:email, :first_name, :last_name, :address]
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
		user_attrs = [:email, :first_name, :last_name, :address]
		doctors = current_patient.units
		render json: doctors.to_json({
			only: [:id],
			include: {
				general_unit: { only: [:id, :name]},
				doctors: { except: [:user_id], include: { user: {only: user_attrs } } }
			}
		}), status: :ok
	end

	def profile
		doctor = Doctor.find_by(id: params[:doctor_id])
		if doctor
			render json: doctor.user.to_json({only: [:first_name, :last_name, :phone_number, :email, :picture, :address]}), status: :ok
		else
			render json: { errors: "The doctor with the assiocated id doesn't exist: #{params[:doctor_id]}" }, status: :not_found
		end
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
