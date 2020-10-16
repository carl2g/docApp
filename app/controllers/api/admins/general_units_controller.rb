class Api::Admins::GeneralUnitsController < ApplicationController

  def index
    modules = GeneralUnit.select(:color, :icon, :id, :name)
		render json: { modules: modules }, status: :ok
  end

end
