class Patient < ApplicationRecord

	# class field
	# =======================================
	# user_id: 		integer
	# general_units_id 	integer
	# =======================================

	# Association objects
	has_one		:user
	has_many	:units
	has_many	:general_units,	through: :units
	has_many	:doctor_units, through: :units
	has_many	:doctors,	through: :doctor_units

	# Delegations
	delegate	:notes, to: :notes
	delegate	:login_token, :email, :first_name, :last_name, to: :user

	# Validations
	validates	:user_id, presence: true

	# Init  and create patient
	def self.createPatient(params)
		new_user 	= User.generate_user(params)
		patient 	= Patient.new({user_id: new_user.id})
		unless patient.save
			patient.errors.clear
			patient.errors.merge!(new_user.errors)
			new_user.destroy
		end
		return patient
	end

	# Get all existing notes
	def notes
		self.units.sum { |i| i.notes }
	end

	# Add a Unit to a user
	def addUnit(general_unit)
		return false if general_unit.nil? || self.has_unit?(general_unit)
		self.units << Unit.new({general_unit_id: general_unit})
		self.save
	end

	# Check if patient have module
	def has_unit?(general_unit)
		self.general_unit_ids.include?(general_unit)
	end

	# Fetch user associated with patient
	def user
		User.find(self.user_id)
	end

end
