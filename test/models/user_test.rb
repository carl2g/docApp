require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "generate user with valid params" do
    User.generate_user(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
    # user = User.new(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
    # user.save
 #   u = User.find_by(email: 'test@hotmail.com')
#    puts "#{u.inspect}"
    assert User.find_by(email: 'test@hotmail.com')
  end

  test "generate user with invalid params - no first_name" do
    User.generate_user(last_name: 'test', email: 'test@hotmail.com', password: 'testest')
    assert_not User.find_by(email: 'test@hotmail.com')
  end

  test "generate user with invalid params - no last_name" do
    User.generate_user(first_name: 'test', email: 'test@hotmail.com', password: 'testest')
    assert_not User.find_by(email: 'test@hotmail.com')
  end

  test "generate user with invalid params - no email" do
    User.generate_user(first_name: 'test', last_name: 'test', password: 'testest')
    assert_not User.find_by(first_name: 'test', last_name: 'test')
  end

  test "generate user with invalid params - no password" do
    User.generate_user(first_name: 'test', last_name: 'test', email: 'test@hotmail.com')
    assert_not User.find_by(email: 'test@hotmail.com')
  end

  test "generate user with invalid params - short password" do
    User.generate_user(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'test')
    assert_not User.find_by(email: 'test@hotmail.com')
  end

  test "valid authenticate" do
    User.generate_user(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
    assert User.authenticate('test@hotmail.com', 'testest')
  end

  test "invalid authenticate - invalid password" do
    User.generate_user(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
    assert_nil User.authenticate('test@hotmail.com', 'testesta')
  end

  test "invalid authenticate - invalid email" do
    User.generate_user(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
    assert_nil User.authenticate('test@hotmail.fr', 'testest')
  end

  test "invalid authenticate" do
    assert_nil User.authenticate('test@hotmail.com', 'testest')
  end

end
