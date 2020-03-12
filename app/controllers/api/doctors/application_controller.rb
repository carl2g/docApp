class Api::Doctors::ApplicationController < ApplicationController
	before_action :is_doctor?, except: [:signin]
end
