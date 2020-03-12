class Api::Patients::GeneralUnitsController < Api::Patients::ApplicationController

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

end
