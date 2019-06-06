require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest
    test "valid login" do
        post "/api/login", params: {password: "12345678", email: "patient@gmail.com"}
        assert_response :success
    end

    test "valid logout" do
        post "/api/login", params: {password: "12345678", email: "patient@gmail.com"}
        h = JSON.parse(@response.body)
        post "/api/logout", headers: {'Authorization' => h["login_token"]} 
        assert_response :success
    end
end
