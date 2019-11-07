class Api::Doctors::ProfileController < ApplicationController

  before_action :authenticate_user

  def index
    render json: current_doctor.user.to_json({only: [:id, :email, :first_name, :last_name, :birthdate, :civility] }), status: :ok
  end

end
