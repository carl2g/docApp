require 'test_helper'

class PatientTest < ActiveSupport::TestCase
  # test "valid patient" do
  #   patient = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
  #   assert Patient.take
  # end

  # test "invalid patient" do
  #   patient = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com')
  #   assert_not_nil User.where(email: "test@hotmail.com"), "invalid patient"
  # end

  # test "valid add module" do
  #   patient = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
  #   assert patient.addModule(1)
  # end

  # test "invalid add module" do
  #   patient = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
  #   assert_not patient.addModule(10), "added an invalid module"
  # end

  # test "invalid add same module" do
  #   patient = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
  #   patient.addModule(1)
  #   assert_not patient.addModule(1), "added the module a second time"
  # end

  # test "valid remove module" do
  #   patient = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
  #   patient.addModule(1)
  #   assert patient.removeModule(1)
  # end

  # test "invalid remove module with invalid module" do
  #   patient = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
  #   patient.addModule(1)
  #   assert_not patient.removeModule(2), "removed a module thats not added"
  # end

  # test "invalid remove module without module" do
  #   patient = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
  #   assert_not patient.removeModule(1), "removed a module without module"
  # end

  # test "has_module that return true" do
  #   patient = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
  #   patient.addModule(1)
  #   assert patient.has_module?(1)
  # end

  # test "has_module that return false" do
  #   patient = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
  #   assert_not patient.has_module?(1), "has_module should have return false but returned true"
  # end

  # test "get user from valid patient" do
  #   patient = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
  #   assert patient.user()
  # end

  # test "valid addDoctor" do
  #   patient = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
  #   patient.addModule(1)
  #   assert patient.addDoctor(1, 1)
  # end

  # test "invalid addDoctor without module" do
  #   patient = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
  #   assert_not patient.addDoctor(1, 1), "could add a doctor on a module that the patient doesn't have"
  # end

  # test "invalid addDoctor with invalid doctor id" do
  #   patient = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
  #   patient.addModule(1)
  #   assert_not patient.addDoctor(2, 1)
  # end

  # test "invalid addDoctor with all arg invalid" do
  #   patient = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
  #   assert_not patient.addDoctor(2, 1)
  # end

  # test "valid removeDoctor" do
  #   patient = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
  #   patient.addModule(1)
  #   patient.addDoctor(1, 1)
  #   assert patient.removeDoctor(1, 1)
  # end

  # test "invalid removeDoctor on wrong module id" do
  #   patient = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
  #   patient.addDoctor(1, 1)
  #   assert_not patient.removeDoctor(1, 2), "could remove wrong module"
  # end

  # test "invalid removeDoctor without doctor" do
  #   patient = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
  #   patient.addModule(1)
  #   assert_not_nil patient.removeDoctor(1, 1), "could remove doctor without any doctor"
  # end

  # test "invalid removeDoctor without module" do
  #   patient = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
  #   patient.addDoctor(1, 1)
  #   assert_not patient.removeDoctor(1, 1), "could remove doctor without module"
  # end

  # test "invalid removeDoctor without anything" do
  #   patient = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
  #   assert_not patient.removeDoctor(1, 1), "could remove doctor without anything"
  # end

  # test "getDoctor info" do
  #   patient = Patient.createPatient(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
  #   patient.addDoctor(1, 1)
  #   assert patient.getDoctorsInfo()
  # end

end