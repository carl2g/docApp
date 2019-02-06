class Api::DModulesController < ApplicationController

	def index
		modules = DModule.select(:color, :icon, :id, :name)
		render json: { modules: modules }, status: :ok
	end

end
