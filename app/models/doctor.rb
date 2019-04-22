class Doctor < ApplicationRecord

	# class field
	# =======================================
	# patients: 	obj collection
	# user_id: 		integer
	# =======================================

	# Association objects
	has_many 	:i_modules
	has_many 	:g_modules, through: :i_modules
	has_many 	:patients, 	through: :i_modules

	# Delegations
	delegate 	:login_token, :email, :first_name, :last_name, to: :user

	# Validations
	validates 	:user_id, 	presence: true

	# create a doctor
	def self.createDoctor(params)
		new_user 	= User.generate_user(params)
		doctor 	= Doctor.new({user_id: new_user.id})
		unless doctor.save
			doctor.errors.clear
			doctor.errors.merge!(new_user.errors)
		end
		return doctor
	end

	# Fetch user associated with doctor
	def user
		User.find_by(id: self.user_id)
	end

	# Get infos of all doctors in db
	def self.getInfos
		Doctor.all.map(&:getInfo)
	end

	# Get basic infos on a doctor
	def getInfo
		{
			id: 		self.id,
			email: 	self.email,
			first_name: self.first_name,
			last_name: 	self.last_name

		}
	end

end
