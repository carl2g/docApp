require 'test_helper'

class PatientTest < ActiveSupport::TestCase

  test "valid createPatient" do
    assert Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest', civility: 'Mr', birthdate: '25/04/1998')
  end

  test "generate patient with invalid params - no first_name" do
    Patient.createPatient(last_name: 'test', email: 'test@hotmail.com', password: 'testest')
    assert_not User.find_by(email: 'test@hotmail.com')
  end

  test "generate patient with invalid params - no last_name" do
    Patient.createPatient(first_name: 'test', email: 'test@hotmail.com', password: 'testest')
    assert_not User.find_by(email: 'test@hotmail.com')
  end

  test "generate patient with invalid params - no email" do
    Patient.createPatient(first_name: 'test', last_name: 'test', password: 'testest')
    assert_not User.find_by(first_name: 'test', last_name: 'test')
  end

  test "generate patient with invalid params - no password" do
    Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com')
    assert_not User.find_by(email: 'test@hotmail.com')
  end

  test "generate patient with invalid params - short password" do
    Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'test')
    assert_not User.find_by(email: 'test@hotmail.com')
  end

  test "valid add unit" do
    p = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest', civility: 'Mr', birthdate: '25/04/1998')
    assert p.addUnit(GeneralUnit.find_by(name: 'diabetes').id)
  end

  test "invalid add unit" do
    p = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
    assert_not p.addUnit(999999)
  end

end