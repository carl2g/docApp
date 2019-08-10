require 'test_helper'

class DoctorTest < ActiveSupport::TestCase

  test "valid createDoctor" do
    assert Doctor.createDoctor({first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest'}, [1])
  end

  test "generate Doctor with invalid params - no first_name" do
    Doctor.createDoctor({last_name: 'test', email: 'test@hotmail.com', password: 'testest'}, [1])
    assert_not User.find_by(email: 'test@hotmail.com')
  end

  test "generate Doctor with invalid params - no last_name" do
    Doctor.createDoctor({first_name: 'test', email: 'test@hotmail.com', password: 'testest'}, [1])
    assert_not User.find_by(email: 'test@hotmail.com')
  end

  test "generate Doctor with invalid params - no email" do
    Doctor.createDoctor({first_name: 'test', last_name: 'test', password: 'testest'}, [1])
    assert_not User.find_by(first_name: 'test', last_name: 'test')
  end

  test "generate Doctor with invalid params - no password" do
    Doctor.createDoctor({first_name: 'test', last_name: 'test', email: 'test@hotmail.com'}, [1])
    assert_not User.find_by(email: 'test@hotmail.com')
  end

  test "generate Doctor with invalid params - short password" do
    Doctor.createDoctor({first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'test'}, [1])
    assert_not User.find_by(email: 'test@hotmail.com')
  end

end