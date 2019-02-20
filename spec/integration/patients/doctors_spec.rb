require 'swagger_helper'

describe 'Doctors of patient' do

  path '/api/patients/doctors' do

    get 'get all doctors' do
      tags 'Patient doctor controller'
      consumes 'application/json'
      security [Bearer: {}]
      response '200', 'patients created' do
        let(:doctor) { { title: 'foo', content: 'bar' } }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:doctor) { { title: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/patients/my_doctors' do

    get 'get the patient doctors' do
      tags 'Patient doctor controller'
      consumes 'application/json'
      security [Bearer: {}]
      response '200', 'patients created' do
        let(:doctor) { { title: 'foo', content: 'bar' } }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:doctor) { { title: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/patients/:id/add_doctor' do

    get 'assigne doctor to patient' do
      tags 'Patient doctor controller'
      consumes 'application/json'
      security [Bearer: {}]
      parameter in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name:  { type: :string },
          email:      { type: :string },
          password:   { type: :string },
        },
        required: [ :first_name, :last_name, :email, :password ]
      }
      response '200', 'patients created' do
        let(:doctor) { { title: 'foo', content: 'bar' } }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:doctor) { { title: 'foo' } }
        run_test!
      end
    end
  end


end
