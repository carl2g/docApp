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
		attrs = [:id, :email, :first_name, :last_name]
		Doctor.all.map do |elem|
			elem.to_json_model(keep_attrs: attrs)
		end
	end

	def to_json_model(keep_attrs: [], reject_attrs: [])
		doctor = self.reject_attributes
		doctor[:email] = self.email
		doctor[:first_name] = self.first_name
		doctor[:last_name] = self.last_name
		if keep_attrs.empty?
			doctor.reject! {|key, val| reject_attrs.include?(key.to_sym) }
		else
			doctor.select! {|key, val| keep_attrs.include?(key.to_sym) }
		end
		return doctor
	end

end
