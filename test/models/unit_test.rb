require 'test_helper'

class UnitTest < ActiveSupport::TestCase

  test "valid add Doctor" do
    p = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
    p.addUnit(GeneralUnit.find_by(name: 'diabetes').id)
    patient_unit = p.units.take()
    patient_unit.addDoctor(Doctor.take().id)
    assert Unit.find_by(doctor_id: Doctor.take().id)
  end

  test "invalid add Doctor" do
    p = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
    p.addUnit(GeneralUnit.find_by(name: 'diabetes').id)
    patient_unit = p.units.take()
    patient_unit.addDoctor(99999999999)
    assert_not Unit.find_by(doctor_id: 99999999999)
  end

  test "valid remove Doctor" do
    p = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
    p.addUnit(GeneralUnit.find_by(name: 'diabetes').id)
    patient_unit = p.units.take()
    patient_unit.addDoctor(Doctor.take().id)
    patient_unit.removeDoctor()
    assert_not Unit.find_by(doctor_id: Doctor.take().id)
  end

  test "invalid remove Doctor" do
    p = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
    p.addUnit(GeneralUnit.find_by(name: 'diabetes').id)
    patient_unit = p.units.take()
    assert patient_unit.removeDoctor()
  end

  test "valid add note" do
    p = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
    p.addUnit(GeneralUnit.find_by(name: 'diabetes').id)
    patient_unit = p.units.take()
    patient_unit.addNote({test: "qzodjqs", po: "azeae"})
    assert p.notes
  end

end
