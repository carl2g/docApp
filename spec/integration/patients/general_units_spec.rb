require 'swagger_helper'

describe 'Patients / General Units controller' do

  path '/api/patients/general_units/{general_unit_id}/add_unit' do

    patch 'add unit' do
      tags 'Patient / General Units'
      security [{ APIKeyHeader: [] }]
      consumes 'application/json'
      parameter name: :general_unit_id, in: :path, type: :integer

      response '201', 'patients created' do
        let(:patients) {}
        run_test!
      end

      response '404', 'Module not found' do
        let(:patients) { }
        run_test!
      end

      response '422', 'invalid request' do
        let(:patients) { }
        run_test!
      end
    end
  end

  path '/api/patients/general_units' do

    get 'get all existing unit' do
      tags 'Patient / General Units'
      security [{ APIKeyHeader: [] }]
      consumes 'application/json'

      response '201', 'patients created' do
        let(:patients) {}
        run_test!
      end

      response '404', 'Module not found' do
        let(:patients) { }
        run_test!
      end

      response '422', 'invalid request' do
        let(:patients) { }
        run_test!
      end
    end
  end

end
