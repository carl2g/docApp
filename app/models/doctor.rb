class Doctor < ApplicationRecord

	include ActiveModel::Serializers::JSON

	has_one 	:user, 	as: :user_type
	
	first_name  = -> { 	self.user.first_name 	}
	last_name 	= -> { 	self.user.last_name	}
	email 	= -> { 	self.user.email		}
	password 	= -> { 	self.user.password 	}
	login_token = -> { 	self.user.login_token 	}

	def self.createDoctor(params)
		doctor = Doctor.create
		doctor.update({ user: User.create(params) })
		if doctor.user.nil?
			doctor.destroy
			doctor = nil
		end
		return doctor
	end

  	def self.authenticate(email, password)
  		user = User.authenticate(email, password)
  		if user
  			return user.doctor
  		end
  		return nil
  	end

end
