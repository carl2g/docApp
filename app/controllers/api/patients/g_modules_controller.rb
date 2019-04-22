class Api::Patients::GModulesController < ApplicationController

	before_action :authenticate_user

	def index
		modules = GModule.select(:color, :icon, :id, :name)
		render json: { modules: modules }, status: :ok
	end

	def add_module
		if current_patient.addModule(params[:g_module_id])
			render json: {}, status: :ok
		else
			render json: { errors: current_patient.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def remove_module
		if current_patient.removeModule(params[:g_module_id])
			render json: {}, status: :ok
		else
			render json: { errors: current_patient.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def my_modules
		modules = current_patient.g_modules
		render json: { modules: modules }
	end

end
