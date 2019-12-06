require 'swagger_helper'

describe 'Doctor / Patients controller' do

  path '/api/doctors/notes' do

    get 'get all notes' do
      tags 'Doctor / Note'
      security [{ APIKeyHeader: [] }]
      consumes 'application/json'

      response '200', 'ok' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

end
