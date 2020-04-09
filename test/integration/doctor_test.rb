require 'test_helper'

class DoctorControllerTest < ActionDispatch::IntegrationTest

    def login
        post "/api/login", params: {session: {password: "12345678", email: "doctor@gmail.com"}}
        return JSON.parse(@response.body)
    end

    test "valid signin" do
        post "/api/doctors/signin",
            params: {first_name: "test",
                last_name: "test",
                password: "testest",
                phone_number: "0616728356",
                email: "test@test.com",
                birthdate: '25/04/1998',
                civility: 'Mr',
                default_units: [1, 2]
            }
        assert_response :success
    end

    test "invalid signin" do
        post "/api/doctors/signin",
            params: {last_name: "test",
                password: "testest",
                phone_number: "0616728356",
                email: "test@test.com",
                default_units: [1]
            }
        assert_response 422
    end

    test "invalid signin - doctor already exist" do
        post "/api/doctors/signin",
            params: {first_name: "doctor",
                last_name: "doctor",
                password: "12345678",
                phone_number: "0616728356",
                email: "doctor@gmail.com",
                default_units: [1, 2]
            }
        assert_response 422
    end

    test "doctor valid add unit" do
        hash = login()
        patch "/api/doctors/general_units/3/add", headers: { 'Authorization' => hash["login_token"] }
        assert_response :success
    end

    test "doctor invalid add unit" do
        hash = login()
        patch "/api/doctors/general_units/1/add", headers: { 'Authorization' => hash["login_token"] }
        assert_response 422
    end

    test "doctor valid remove unit" do
        hash = login()
        patch "/api/doctors/general_units/1/remove", headers: { 'Authorization' => hash["login_token"] }
        assert_response :success
    end

    test "doctor invalid remove unit" do
        hash = login()
        patch "/api/doctors/general_units/1989/remove", headers: { 'Authorization' => hash["login_token"] }
        assert_response 422
    end
end