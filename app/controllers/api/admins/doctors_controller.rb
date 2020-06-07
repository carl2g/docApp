class Api::Admins::DoctorsController < ApplicationController

  def index
		data = []
		Doctor.find_each do |pat|
		  data.push(pat.user)
		end
		attributes = user_attr.concat([:id])
		attributes.delete(:picture)
		render json: data.to_json(only: attributes), status: :ok
	end

	def update
		doctor = User.find_by(id: params[:id])
		if doctor && doctor.update(permited_params)
      render json: doctor.to_json(only: user_attr), status: :ok
    else
      render json: { errors: "Doctor you tried to update informations doesn't exist: #{params[:id]}" }, status: :not_found
    end
	end

	def delete
		doctor = Doctor.find_by(user_id: params[:id])
		if doctor
				User.delete(id: params[:id])
				doctor.destroy
		    render status: :ok
		else
		    render json: { errors: "Doctor you tried to delete doesn't exist: #{params[:id]}" }, status: :not_found
		end
	end

	private

		def user_attr
			[:first_name, :last_name, :email, :phone_number, :birthdate, :civility, :picture, :address]
		end

		def permited_params
			params.permit(user_attr)
	 	end
end
