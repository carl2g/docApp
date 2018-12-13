class Patient < ApplicationRecord

	include ActiveModel::Serializers::JSON

	has_one 	:user, as: :user_type

	def login_token
		self.user.login_token
	end

	def password
		self.user.password
	end

	def email
		self.user.email
	end

	def last_name
		self.user.last_name
	end

	def first_name
		self.user.first_name
	end

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
