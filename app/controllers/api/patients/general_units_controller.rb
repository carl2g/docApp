class Api::Patients::GeneralUnitsController < ApplicationController

	before_action :authenticate_user

	def index
		modules = GeneralUnit.select(:color, :icon, :id, :name)
		render json: { modules: modules }, status: :ok
	end

	def add_unit
		if current_patient.addUnit(params[:general_unit_id])
			render json: {}, status: :ok
		else
			render json: { errors: current_patient.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def info
		unit = GeneralUnit.find_by(id: params[:id])
		if unit
			render json: unit.to_json(), status: :ok
		else
			render json: { errors: "no general_unit found with id: #{params[:id]}" }, status: :not_found
		end
	end

end
