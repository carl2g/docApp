require 'swagger_helper'

describe 'Patients / Doctors controller' do

  path '/api/patients/doctors' do

    get 'get all doctors' do
      tags 'Patient / Doctors'
      consumes 'application/json'
      security [{ APIKeyHeader: [] }]

      response '200', 'patients created' do
        run_test!
      end

      response '401', 'Unauthorized' do
        run_test!
      end
    end
  end

  path '/api/patients/doctors/my_doctors' do

    get 'get the patient doctors' do
      tags 'Patient / Doctors'
      consumes 'application/json'
      security [{ APIKeyHeader: [] }]
      response '200', 'patients created' do
        run_test!
      end

      response '401', 'Unauthorized' do
        run_test!
      end
    end
  end

end
