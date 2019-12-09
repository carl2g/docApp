class Api::Admins::DoctorsController < ApplicationController
	before_action :authenticate_user, except: [:is_admin?]

  def index
		data = []
		Doctor.find_each do |pat|
		  data.push(pat.user)
		end
		render json: data.to_json({except: [:user_id, :login_token, :password, :last_connection, :created_at, :updated_at]}), status: :ok
	end

	def update
    doctor = Doctor.find_by(id: params[:id])
		if doctor
			doctor.user.update(permited_params)
      render json: doctor.user.to_json({only: user_attr()}), status: :ok
    else
      render json: { errors: "Doctor you tried to update informations doesn't exist: #{params[:id]}" }, status: :not_found
    end
	end

	def delete
		doctor = Doctor.find_by(id: params[:id])
		if doctor
		    Doctor.delete(doctor.user_id)
		    render status: :ok
		else
		    render json: { errors: "Doctor you tried to delete doesn't exist: #{params[:id]}" }, status: :not_found
		end
	end

	private

		def user_attr
			[:first_name, :last_name, :email, :phone_number, :birthdate, :civility, :picture]
		end

		def permited_params
			params.permit(user_attr)
	 	end
end
