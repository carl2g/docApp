require 'swagger_helper'

describe 'Patients / Notes controller' do

  path '/api/patients/notes' do

    post 'create a note as patient' do
      tags 'Patient / Notes'
      security [Bearer: {}]
      consumes 'application/json'
      parameter name: :notes, in: :body, schema: {
        type: :object,
        properties: {
          module_id: { type: :integer },
          data: {type: :string}
        },
        required: [ :module_id ]
      }

      response '201', 'note created' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  path '/api/patients/notes/{note_id}' do

    delete 'delete a note as patient' do
      tags 'Patient / Notes'
      security [Bearer: {}]
      consumes 'application/json'
      parameter name: :note_id, in: :path, type: :integer

      response '201', 'note destroyed' do
        run_test!
      end

      response '404', 'not found' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  path '/api/patients/notes/{note_id}' do

    patch 'update a note as patient' do
      tags 'Patient / Notes'
      security [Bearer: {}]
      consumes 'application/json'
      parameter name: :note_id, in: :path, type: :integer
      parameter name: :note,   in: :body, schema: {
        type: :object,
        properties: {
          data: {type: :string}
        },
        required: [ :module_id ]
      }
      response '200', 'note created' do
        run_test!
      end

      response '404', 'not found' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end

    end
  end

  path '/api/patients/notes' do

    get 'get all notes' do
      tags 'Patient / Notes'
      security [Bearer: {}]
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
