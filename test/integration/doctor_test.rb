require 'test_helper'

class DoctorControllerTest < ActionDispatch::IntegrationTest
    test "valid signin" do
        post "/api/doctors/signin",
            params: {first_name: "test",
                last_name: "test",
                password: "testest",
                phone_number: "0616728356",
                email: "test@test.com"}
        assert_response :success
    end

    test "invalid signin" do
        post "/api/doctors/signin",
            params: {last_name: "test",
                password: "testest",
                phone_number: "0616728356",
                email: "test@test.com"}
        assert_response 422
    end

    test "invalid signin - doctor already exist" do
        post "/api/doctors/signin",
            params: {first_name: "doctor",
                last_name: "doctor",
                password: "12345678",
                phone_number: "0616728356",
                email: "doctor@gmail.com"}
        assert_response 422
    end

end