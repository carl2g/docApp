class Patient < ApplicationRecord

	include ActiveModel::Serializers::JSON
	
	has_one 	:user, as: :user_type

	first_name  = -> { 	self.user.first_name 	}
	last_name 	= -> { 	self.user.last_name	}
	email 	= -> { 	self.user.email		}
	password 	= -> { 	self.user.password 	}
	login_token = -> { 	self.user.login_token 	}

	def self.createPatient(params)
		patient = Patient.create
		patient.update({ user: User.create(params) })
		if patient.user.nil?
			patient.destroy
			patient = nil
		end
		return patient
	end

	def self.authenticate(email, password)
  		user = User.authenticate(email, password)
  		if user
  			return user.patient
  		end
  		return nil
  	end

end
