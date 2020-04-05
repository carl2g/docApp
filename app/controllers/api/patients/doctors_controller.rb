class Api::Patients::DoctorsController < ApplicationController

	before_action :authenticate_user

	def index
		user_attrs = [:email, :first_name, :last_name]
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

	def profile
		doctor = Doctor.find_by(id: params[:id])
		if doctor
			render json: doctor.user.to_json({only: [:first_name, :last_name, :phone_number, :email, :picture]}), status: :ok
		else
			render json: { errors: "The doctor with the assiocated id doesn't exist: #{params[:id]}" }, status: :not_found
		end
	end

	def by_module
		doctors = Doctor.joins(:general_unit_doctors).where(general_unit_doctors: {general_unit_id: params[:id]})
		if doctors
			render json: doctors.to_json({only: [:id, :first_name, :last_name]}), status: :ok
		else
			render json: { errors: "There is no doctor for this module or this module doesn't exist: #{params[:id]}" }, status: :not_found
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
