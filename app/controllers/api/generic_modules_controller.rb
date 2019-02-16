class Api::GenericModulesController < ApplicationController

	def index
		modules = GenericModule.select(:color, :icon, :id, :name)
		render json: { modules: modules }, status: :ok
	end

end
