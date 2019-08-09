class Doctor < ApplicationRecord

	# class Doctor
	# =======================================
	# patients: 	obj collection
	# user_id: 		integer
	# =======================================

	# Association objects
	has_many	:doctor_units
	has_many	:units, through: :doctor_units
	has_many	:general_units, through: :units
	has_many	:patients, through: :units

	# Delegations
	delegate	:login_token, :email, :first_name, :last_name, :full_name, to: :user

	# Validations
	validates	:user_id, presence: true

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

end
