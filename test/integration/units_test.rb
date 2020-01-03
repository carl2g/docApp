require 'test_helper'

class UnitsControllerTest < ActionDispatch::IntegrationTest

    def login
        post "/api/login", params: {session: { password: "12345678", email: "patient@gmail.com"}}
        return JSON.parse(@response.body)
    end

    test "index of units" do
        hash = login()
        get "/api/patients/general_units", headers: {'Authorization' => hash["login_token"]}
        assert_response :success
    end

    test "valid add units" do
        lhash = login()
        patch "/api/patients/general_units/1/add_unit", headers: {'Authorization' => lhash["login_token"]}
        assert_response :success
    end

    test "text multiple add units" do
        lhash = login()
        patch "/api/patients/general_units/1/add_unit", headers: {'Authorization' => lhash["login_token"]}
        patch "/api/patients/general_units/1/add_unit", headers: {'Authorization' => lhash["login_token"]}
        assert_response 422
    end

    test "invalid add units" do
        lhash = login()
        patch "/api/patients/general_units/9999999/add_unit", headers: {'Authorization' => lhash["login_token"]}
        assert_response 422
    end

    test "valid index notes by units" do
        lhash = login()
        patch "/api/patients/general_units/1/add_unit", headers: {'Authorization' => lhash["login_token"]}
        get "/api/patients/units/1/notes", headers: {'Authorization' => lhash["login_token"]}
        assert_response :success
    end

    test "invalid index notes by units" do
        lhash = login()
        get "/api/patients/units/9999999/notes", headers: {'Authorization' => lhash["login_token"]}
        assert_response 404
    end

    test "valid add_note" do
        lhash = login()
        patch "/api/patients/general_units/1/add_unit", headers: {'Authorization' => lhash["login_token"]}
        post "/api/patients/units/1/add_note", params: {data: {test1: 'adad', test2: 'dqsd'}}, headers: {'Authorization' => lhash["login_token"]}
        assert_response :success
    end

    test "invalid add_note - no unit" do
        lhash = login()
        post "/api/patients/units/999999999/add_note", params: {data: {test1: 'adad', test2: 'dqsd'}}, headers: {'Authorization' => lhash["login_token"]}
        assert_response 404
    end

    test "valid add doctor" do
        lhash = login()
        patch "/api/patients/general_units/1/add_unit", headers: {'Authorization' => lhash["login_token"]}
        patch "/api/patients/units/1/add_doctor", params: {doctor_id: '1'}, headers: {'Authorization' => lhash["login_token"]}
        assert_response :success
    end

    test "invalid add doctor - doctor doesn't exist" do
        lhash = login()
        patch "/api/patients/general_units/1/add_unit", headers: {'Authorization' => lhash["login_token"]}
        patch "/api/patients/units/1/add_doctor", params: {doctor_id: '9999999999'}, headers: {'Authorization' => lhash["login_token"]}
        assert_response 404
    end

    test "invalid add doctor - unit doesn't exist" do
        lhash = login()
        patch "/api/patients/units/9999999999/add_doctor", params: {doctor_id: '1'}, headers: {'Authorization' => lhash["login_token"]}
        assert_response 404
    end

    test "valid remove doctor" do
        lhash = login()
        patch "/api/patients/general_units/1/add_unit", headers: {'Authorization' => lhash["login_token"]}
        patch "/api/patients/units/1/add_doctor", params: {doctor_id: '1'}, headers: {'Authorization' => lhash["login_token"]}
        patch "/api/patients/units/1/remove_doctor", params: {doctor_id: '1'}, headers: {'Authorization' => lhash["login_token"]}
        assert_response :success
    end

    test "invalid remove doctor - doctor not added" do
        lhash = login()
        patch "/api/patients/general_units/1/add_unit", headers: {'Authorization' => lhash["login_token"]}
        patch "/api/patients/units/1/remove_doctor", params: {doctor_id: 'id'}, headers: {'Authorization' => lhash["login_token"]}
        assert_response 404
    end

    test "invalid remove doctor - bad unit" do
        lhash = login()
        patch "/api/patients/general_units/1/add_unit", headers: {'Authorization' => lhash["login_token"]}
        patch "/api/patients/units/1/add_doctor", params: {doctor_id: '1'}, headers: {'Authorization' => lhash["login_token"]}
        patch "/api/patients/units/999999999/remove_doctor", params: {doctor_id: '1'}, headers: {'Authorization' => lhash["login_token"]}
        assert_response 404
    end

end