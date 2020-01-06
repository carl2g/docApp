class Api::Admins::DoctorsController < ApplicationController
	before_action :authenticate_user, except: [:signin]  # TODO: remove
#	before_action :authenticate_user, except: [:is_admin?] TODO: put back

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
    doctor = Doctor.find_by(id: params[:id])
	if doctor
		doctor.user.update(permited_params)
      	render json: doctor.user.to_json(user_attr), status: :ok
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
			params.require(:id).permit(user_attributes: user_attr)
	 	end
end
