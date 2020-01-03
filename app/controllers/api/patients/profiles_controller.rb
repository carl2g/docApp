class Api::Patients::ProfilesController < ApplicationController

  before_action :authenticate_user

  def index
    render json: current_patient.user.to_json({only: user_data }), status: :ok
  end

  def update
    params.require(:password)
    if current_patient.user.is_password_valid(params[:password])
      current_patient.user.update(permited)
      render json: current_patient.user.to_json({only: user_data }), status: :ok
    else
      render json: { errors: "Invalid password for user: #{current_patient.user.id}, cant change his datas"}, status: :forbidden
    end
  end

  def change_password
    params.require(:old_password, :new_password)
    if current_patient.user.is_password_valid(params[:old_password])
      if current_patient.user.update(password: params[:new_password])
        render status: :ok
      else
        render json: { errors: "New password is too short for user: #{current_patient.user.id}, password length need to be superior or equal to 6 characters"}, status: :forbidden
      end
    else
      render json: { errors: "Invalid password for user: #{current_patient.user.id}, cant change his password"}, status: :forbidden
    end
  end

  def check_password
    params.require(:password)
    if current_patient.user.is_password_valid(params[:password])
      render status: :ok
    else
      render json: { errors: "Invalid password for user: #{current_patient.user.id}"}, status: :forbidden
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

  def user_data
    [
      :id,
      :first_name,
      :last_name,
      :email,
      :phone_number,
      :birthdate,
      :civility,
      :picture
    ]
  end

end
