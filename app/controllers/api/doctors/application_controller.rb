class Api::Doctors::ApplicationController < ApplicationController
	before_action :authenticate_user, except: [:signin]
	before_action :is_doctor?
end
