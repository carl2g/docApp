ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  def setup
    GeneralUnit.create!({name: 'diabetes', 	color: 'blue', 	icon: 'to be defined'})
    GeneralUnit.create!({name: 'asthma', 	color: 'red', 	icon: 'to be defined'})
    GeneralUnit.create!({name: 'arthritis', color: 'green', 	icon: 'to be defined'})
    Patient.createPatient({first_name: 'patient', last_name: 'patient', email: 'patient@gmail.com', password: '12345678'})
    Doctor.createDoctor({first_name: 'doctor', last_name: 'doctor', email: 'doctor@gmail.com', password: '12345678', default_units: [1, 2]})
  end
  # Add more helper methods to be used by all tests here...
end
