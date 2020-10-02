require 'test_helper'

class NoteLimitsTest < ActiveSupport::TestCase

	 setup do
	 	patient = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test_limit@hotmail.com', password: 'testest', civility: 'Mr', birthdate: '25/04/1998')
	 	doctor = Doctor.createDoctor({first_name: 'carl_test', last_name: 'carl_test', email: 'degentilecarl+test@gmail.com', password: '12345678', birthdate: '25/05/1998', civility: 'Mr', phone_number: '00918989', picture: '', default_units: [1, 2]})
		gen_unit = GeneralUnit.create!({name: 'diabetes',  color: 'blue',  icon: 'to be defined'})

	    patient.addUnit(gen_unit.id)
		diabet_unit = patient.units.first
		diabet_unit.addDoctor(doctor.id)
	  end

	test "up limit exceed" do
		patient = Patient.joins("INNER JOIN users ON users.id = patients.user_id").find_by(users: {email: 'test_limit@hotmail.com'})
		doctor = Doctor.joins("INNER JOIN users ON users.id = doctors.user_id").find_by(users: {email: 'degentilecarl+test@gmail.com'})
		
		diabet_unit = patient.units.first
		diabet_unit.addNote({"Glucide": 10})
		doctor.doctor_units.first.update(fields_limits: {
			"Glucide": {"min_limit": 0, "max_limit": 9.9 }
		})
		doctor.share_notes(diabet_unit.id, patient.notes.first.id)
		assert doctor.doctor_units.first.doctor_unit_notes.first.anomali?
  	end

  	test "low limit exceed" do
		patient = Patient.joins("INNER JOIN users ON users.id = patients.user_id").find_by(users: {email: 'test_limit@hotmail.com'})
		doctor = Doctor.joins("INNER JOIN users ON users.id = doctors.user_id").find_by(users: {email: 'degentilecarl+test@gmail.com'})
		
		diabet_unit = patient.units.first
		diabet_unit.addNote({"Glucide": -0.1})
		doctor.doctor_units.first.update(fields_limits: {
			"Glucide": {"min_limit": 0, "max_limit": 9.9 }
		})
		doctor.share_notes(diabet_unit.id, patient.notes.first.id)
		assert doctor.doctor_units.first.doctor_unit_notes.first.anomali?
  	end

  	test "limit exceed after update" do
		patient = Patient.joins("INNER JOIN users ON users.id = patients.user_id").find_by(users: {email: 'test_limit@hotmail.com'})
		doctor = Doctor.joins("INNER JOIN users ON users.id = doctors.user_id").find_by(users: {email: 'degentilecarl+test@gmail.com'})
		
		diabet_unit = patient.units.first
		diabet_unit.addNote({"Glucide": 1})
		doctor.doctor_units.first.update(fields_limits: {
			"Glucide": {"min_limit": 0, "max_limit": 9.9 }
		})
		doctor.share_notes(diabet_unit.id, patient.notes.first.id)
		diabet_unit.notes.first.update(data: {"Glucide": -1})
		assert doctor.doctor_units.first.doctor_unit_notes.first.anomali?
  	end

  	test "limit not exceeed" do
		patient = Patient.joins("INNER JOIN users ON users.id = patients.user_id").find_by(users: {email: 'test_limit@hotmail.com'})
		doctor = Doctor.joins("INNER JOIN users ON users.id = doctors.user_id").find_by(users: {email: 'degentilecarl+test@gmail.com'})
		
		diabet_unit = patient.units.first
		diabet_unit.addNote({"Glucide": 9.9})
		doctor.doctor_units.first.update(fields_limits: {
			"Glucide": {"min_limit": 0, "max_limit": 10 }
		})
		doctor.share_notes(diabet_unit.id, patient.notes.first.id)
		assert doctor.doctor_units.first.doctor_unit_notes.first.normal?
  	end

end