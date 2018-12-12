class Doctor < ApplicationRecord

	include ActiveModel::Serializers::JSON

	has_one 	:user, 	as: :user_type

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

	def self.createDoctor(params)
		new_user 	= User.new(params)
		doctor 	= Doctor.create
		new_user.user_type = doctor
		if new_user.save
			doctor.update({ user: new_user })
		else
			doctor.destroy
			return new_user
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
