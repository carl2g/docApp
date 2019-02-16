class Doctor < ApplicationRecord

	# class field
	# =======================================
	# patients: 	obj collection
	# user_id: 		integer
	# =======================================

	has_many 	:patients
	validates 	:user_id, 	presence: true

	def self.createDoctor(params)
		new_user 	= User.generate_user(params)
		doctor 	= Doctor.new({user_id: new_user.id})
		if !doctor.save
			doctor.errors.clear
			doctor.errors.merge!(new_user.errors)
		end
		return doctor
	end

	def user
		User.find_by(id: self.user_id)
	end

	def self.users
		ids = Doctor.pluck(:user_id)
		User.where(id: ids)
	end

end
