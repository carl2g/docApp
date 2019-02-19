class Api::Patients::GenericModulesController < ApplicationController

	before_action :authenticate_user

	def index
		modules = GenericModule.select(:color, :icon, :id, :name)
		render json: { modules: modules }, status: :ok
	end

	def add_module
		if current_patient.addModule(GenericModule.find_by(id: params[:id]))
			render json: {}, status: :ok
		else
			render json: { errors: current_patient.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def remove_module
		if current_patient.removeModule(GenericModule.find_by(id: params[:id]))
			render json: {}, status: :ok
		else
			render json: { errors: current_patient.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def my_modules
		modules = current_patient.generic_modules
		render json: { modules: modules }
	end

end
