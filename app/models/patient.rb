class Patient < ApplicationRecord

	# class field
	# =======================================
	# user_id: 		integer
	# general_units_id 	integer
	# =======================================

	# Association objects
	#has_one		:user, dependent: :destroy
	has_many	:units, dependent: :destroy
	has_many	:general_units,	through: :units
	has_many	:doctor_units, 	through: :units
	has_many	:doctors, through: :doctor_units

	# Delegations
	delegate	:notes, to: :notes
	delegate	:login_token, :email, :first_name, :last_name, to: :user

	# Validations
	validates	:user_id, presence: true

	# Init  and create patient
	def self.createPatient(params)
		new_user 	= User.generate_user(params)
		patient 	= Patient.new({user_id: new_user.id, id: new_user.id})
		unless patient.save
			patient.errors.clear
			patient.errors.merge!(new_user.errors)
			new_user.destroy
		end
		return patient
	end

	# Get all existing notes
	def notes
		notes = Note.where(unit_id: self.unit_ids)
		return notes
	end

	# Add a Unit to a user
	def addUnit(general_unit_id)
		general_u = GeneralUnit.find_by(id: general_unit_id)
		return false if general_u.nil? || self.has_unit?(general_unit_id)
		self.general_units << general_u
		return self.save
	end

	# Check if patient have module
	def has_unit?(general_unit)
		u = Unit.find_by(general_unit_id: general_unit, patient_id: self.id)
		return false if u.nil?
		return true
	end

	# Fetch user associated with patient
	def user
		User.find_by(id: self.user_id)
	end

end
