require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "valid user without token" do
    user = User.new(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
    assert user.valid?
  end

  test "valid user with token" do
    user = User.new(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest', login_token: 'tokentest')
    assert user.valid?
  end

  test "invalid user without first_name" do
    user = User.new(last_name: 'test', email: 'test@hotmail.com', password: 'testest')
    refute user.valid?, 'user is valid without first_name'
    assert_not_nil user.errors[:first_name], 'no validation error without first_name'
  end

  test "invalid user without last_name" do
    user = User.new(first_name: 'test', email: 'test@hotmail.com', password: 'testest')
    refute user.valid?, 'user is valid without last_name'
    assert_not_nil user.errors[:last_name], 'no validation error without last_name'
  end

  test "invalid user without email" do
    user = User.new(first_name: 'test', last_name: 'test', password: 'testest')
    refute user.valid?, 'user is valid without email'
    assert_not_nil user.errors[:email], 'no validation error without email'
  end

  test "invalid user without password" do
    user = User.new(first_name: 'test', last_name: 'test', email: 'test@hotmail.com')
    refute user.valid?, 'user is valid without password'
    assert_not_nil user.errors[:password], 'no validation error without password'
  end

  test "invalid user with incorrect password" do
    user = User.new(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'test')
    refute user.valid?, 'user is valid with incorrect password'
    assert_not_nil user.errors[:password], 'no validation error with incorrect password'
  end

  test "check user uniqueness" do
    user1 = User.new(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
    user2 = User.new(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')

    user1.save
    user2.save
    assert_not (User.where(email: 'test@hotmail.com').size() > 1), "created 2 user with same email"
  end

  test "valid generate_user" do
    user = User.generate_user(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
    assert user.valid?
  end

  test "invalid generate_user" do
    user = User.generate_user(first_name: 'test', last_name: 'test', email: 'test@hotmail.com')
    refute user.valid?, 'user is invalid when using generate_user with invalid params'
    assert_not_nil user.errors[:password], 'no validation error without password'
  end

  test "valid user authentification" do
    user = User.generate_user(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
    assert User.authenticate('test@hotmail.com', 'testest')
  end

  test "invalid user authentification, bad pasword" do
    user = User.generate_user(first_name: 'test', last_name: 'test', email: 'test@hotmail.com', password: 'testest')
    refute User.authenticate('test@hotmail.com', 'testesta'), "could authentificate on user with incorrect password"
  end

  test "invalid user authentification without user account" do
    refute User.authenticate('test@hotmail.com', 'testest'), "could authentificate on user without account"
  end

end
