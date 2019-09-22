require 'test_helper'

class UnitTest < ActiveSupport::TestCase

  test "valid add Doctor" do
    p = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest', civility: 'Mr', birthdate: '25/04/1998')
    p.addUnit(GeneralUnit.find_by(name: 'diabetes').id)
    patient_unit = p.units.take()
    patient_unit.addDoctor(Doctor.take().id)
    assert DoctorUnit.find_by(doctor_id: Doctor.take().id, unit_id: patient_unit.id)
  end

  test "invalid add Doctor" do
    p = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest', civility: 'Mr', birthdate: '25/04/1998')
    assert p.addUnit(GeneralUnit.find_by(name: 'diabetes').id)
    assert patient_unit = p.units.take()
    assert_not patient_unit.addDoctor(99999999999)
    assert_not DoctorUnit.find_by(doctor_id: 99999999999, unit_id: patient_unit.id)
  end

  test "valid remove Doctor" do
    p = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest', civility: 'Mr', birthdate: '25/04/1998')
    p.addUnit(GeneralUnit.find_by(name: 'diabetes').id)
    patient_unit = p.units.take()
    doc = Doctor.take()
    assert patient_unit.addDoctor(doc.id)
    assert patient_unit.removeDoctor(doc.id)
    assert_not doc.units.find_by(id: patient_unit.id)
  end

  test "invalid remove Doctor" do
    p = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest', civility: 'Mr', birthdate: '25/04/1998')
    p.addUnit(GeneralUnit.find_by(name: 'diabetes').id)
    patient_unit = p.units.take()
    assert_not patient_unit.removeDoctor(99999999999999)
  end

  test "valid add note" do
    p = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest', civility: 'Mr', birthdate: '25/04/1998')
    p.addUnit(GeneralUnit.find_by(name: 'diabetes').id)
    patient_unit = p.units.take()
    assert patient_unit.addNote({test: "qzodjqs", po: "azeae"})
    assert p.notes
  end

end
