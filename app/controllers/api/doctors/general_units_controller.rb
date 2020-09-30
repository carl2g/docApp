class Api::Doctors::GeneralUnitsController < Api::Doctors::ApplicationController
  before_action :authenticate_user

  def index
    modules = GeneralUnit.select(:color, :icon, :id, :name)
		render json: { modules: modules }, status: :ok
  end

	def info
		unit = GeneralUnit.find_by(id: params[:general_unit_id])
		if unit
			render json: unit.to_json(), status: :ok
		else
			render json: { errors: "no general_unit found with id: #{params[:general_unit_id]}" }, status: :not_found
		end
	end

	def add
		if current_doctor.addGeneralUnit(params[:general_unit_id])
			render json: {}, status: :ok
		else
			render json: { :errors => "Couldn't add the unit cause you either already have it or the unit doesn't exist" }, status: :unprocessable_entity
		end
	end

	def remove
		if current_doctor.removeUnit(params[:general_unit_id])
			render json: {}, status: :ok
		else
			render json: { :errors => "Couldn't remove the unit cause you don't have it" }, status: :unprocessable_entity
		end
	end
end
