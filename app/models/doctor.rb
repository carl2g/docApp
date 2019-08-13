class Doctor < ApplicationRecord

	# class Doctor
	# =======================================
	# patients: 	obj collection
	# user_id: 		integer
	# =======================================

	# Association objects
	has_many	:doctor_units
	has_many	:units, through: :doctor_units
	has_many	:patients, through: :units
	has_many	:general_units, through: :general_unit_doctors

	# Delegations
	delegate	:login_token, :email, :first_name, :last_name, :full_name, to: :user

	# Validations
	validates	:user_id, presence: true

	# create a doctor
	def self.createDoctor(params)
		user_params = {
			first_name: params[:first_name],
			last_name: params[:last_name],
			email: params[:email],
			password: params[:password],
			phone_number: params[:phone_number]
		}

		new_user 	= User.generate_user(user_params)
		doctor 		= Doctor.new({user_id: new_user.id})
		if doctor.save
			self.addGeneralUnits(params[:default_units])
		else
			doctor.errors.clear
			doctor.errors.merge!(new_user.errors)
		end
		return doctor
	end

	def addGeneralUnits(general_unit_ids)
		general_unit_ids.each do |gu_id| 
			gu = GeneralUnit.find_by(id: gu_id)
			if gu && gu.doctors.find_by(id: self.id).nil?
				gu.doctors << self
			end
			gu.save
		end
	end

	# Fetch user associated with doctor
	def user
		User.find_by(id: self.user_id)
	end

	def self.addThisUnit(doctor_id, general_unit_id)
		gu = GeneralUnit.find_by(id: general_unit_id)
		return false if gu.nil?
		gud = GeneralUnitDoctor.new(doctor_id: doctor_id, general_unit_id: general_unit_id)
		return gud.save
	end

	def addUnit(general_unit_id) 
		gud = GeneralUnitDoctor.find_by(doctor_id: self.id, general_unit_id: general_unit_id)
		return false if gud.present?
		return Doctor.addThisUnit(self.id, general_unit_id)
  end

	def removeUnit(general_unit_id)
		gud = GeneralUnitDoctor.find_by(doctor_id: self.id, general_unit_id: general_unit_id)
		return false if gud.nil?
		gud.destroy
		return true
  end

end
