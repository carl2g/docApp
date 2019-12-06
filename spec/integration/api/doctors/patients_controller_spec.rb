require 'swagger_helper'

describe 'Doctor / Patients controller' do

  path '/api/doctors/patients' do

    get 'get all assigne patient for a given doctor' do
      tags 'Doctor / Patient'
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

  # path '/api/doctors/patients' do

  #   get 'get all assigne patient for a given doctor' do
  #     tags 'Doctor / Patient'
  #     security [{ APIKeyHeader: [] }]
  #     consumes 'application/json'

  #     response '200', 'ok' do
  #       run_test!
  #     end

  #     response '422', 'invalid request' do
  #       run_test!
  #     end
  #   end
  # end


end
