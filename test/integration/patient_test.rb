require 'test_helper'

class PatientControllerTest < ActionDispatch::IntegrationTest
    test "valid signin" do
        post "/api/patients/signin",
            params: {first_name: "test",
                last_name: "test",
                password: "testest",
                phone_number: "0616728356",
                email: "test@test.com"}
        assert_response :success
    end

    test "invalid signin" do
        post "/api/patients/signin",
            params: {last_name: "test",
                password: "testest",
                phone_number: "0616728356",
                email: "test@test.com"}
        assert_response 422
    end

    test "invalid signin - patient already exist" do
        post "/api/patients/signin",
            params: {first_name: "patient",
                last_name: "patient",
                password: "12345678",
                phone_number: "0616728356",
                email: "patient@gmail.com"}
        assert_response 422
    end

end
