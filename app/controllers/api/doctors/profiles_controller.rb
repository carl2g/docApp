class Api::Doctors::ProfilesController < ApplicationController

  before_action :authenticate_user

  def index
    render json: current_doctor.user.to_json({only: [:id, :email, :first_name, :last_name, :birthdate, :civility, :picture] }), status: :ok
  end

  def update
    params.require(:password)
    if current_doctor.user.is_password_valid(params[:password])
      current_doctor.user.update(permited)
      render json: current_doctor.user.to_json({only: [:id, :email, :first_name, :last_name, :birthdate, :civility, :picture] }), status: :ok
    else
      render json: { errors: "Invalid password for user: #{current_doctor.user.id}, cant change his datas"}, status: :forbidden
    end
  end

  def change_password
    params.require([:old_password, :new_password])
    if current_doctor.user.is_password_valid(params[:old_password])
      if current_doctor.user.change_password(params[:new_password])
        render status: :ok
      else
        render json: { errors: "New password is too short for user: #{current_doctor.user.id}, password length need to be superior or equal to 6 characters"}, status: :forbidden
      end
    else
      render json: { errors: "Invalid password for user: #{current_doctor.user.id}, cant change his password"}, status: :forbidden
    end
  end

  def check_password
    params.require(:password)
    if current_doctor.user.is_password_valid(params[:password])
      render status: :ok
    else
      render json: { errors: "Invalid password for user: #{current_doctor.user.id}"}, status: :forbidden
    end
  end

  def permited_params
		[
			:first_name,
			:last_name,
			:phone_number,
			:email,
			:civility,
      :birthdate,
      :picture
		]
  end

  def permited
		params.permit(permited_params)
	end

end
