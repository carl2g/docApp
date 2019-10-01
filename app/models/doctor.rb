class Doctor < ApplicationRecord

	# class Doctor
	# =======================================
	# patients: 	obj collection
	# user_id: 		integer
	# =======================================

	# Association objects
	has_many	:doctor_units
	has_many	:units, through: :doctor_units
	has_many 	:notes, through: :doctor_units
	has_many	:patients, through: :units
	has_many	:general_unit_doctors
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
			doctor.addGeneralUnits(params[:default_units])
		else
			doctor.errors.clear
			doctor.errors.merge!(new_user.errors)
		end
		return doctor
	end

	def addGeneralUnits(general_unit_ids)
		general_unit_ids.each do |gu_id|
			self.addGeneralUnit(gu_id)
		end
	end

	def addGeneralUnit(gu_id)
		gu = GeneralUnit.find_by(id: gu_id)
		return false if gu.nil? || gu.doctors.find_by(id: self.id).present?
		gu.doctors << self
		return gu.save
	end

	# Fetch user associated with doctor
	def user
		User.find_by(id: self.user_id)
	end

	def removeUnit(general_unit_id)
		gu = self.general_units.find_by(id: general_unit_id)
		return false if gu.nil?
		return self.general_units.delete(gu).nil? ? false : self.save
  	end

  	def share_notes(unit_id, note_ids)
  		unit = Unit.find_by(id: unit_id)
        patient = unit.patient
        notes = patient.notes.where(id: note_ids)
        doctor_unit = self.doctor_units.find_by(unit_id: unit.id)
        filter = unit.filter
        notes.each do |note|
        	DoctorUnitNote.create!(filter: filter, note: note, doctor_unit: doctor_unit)
        end
  	end

end
