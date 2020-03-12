class Api::Admins::AdminsController < ApplicationController
	
	before_action :authenticate_user, except: [:signin]
	before_action :authenticate_user, except: [:is_admin?] #TODO: put back
	
	def is_admin?
		unless current_user.has_role? :admin
			render status: :unauthorized
		end
	end

end
