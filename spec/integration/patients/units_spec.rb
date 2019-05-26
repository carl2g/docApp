require 'swagger_helper'

describe 'Patients / Units controller' do


	path '/api/patients/units/{unit_id}/add_doctor' do
	    	patch 'assigne doctor to patient' do

		      tags 'Patient / Units'
		      consumes 'application/json'
		      produces 'application/json'
		      security [{ APIKeyHeader: [] }]
		      parameter name: :unit_id, in: :path, type: :integer
		      parameter name: :unit, in: :body, schema: {
		        type: :object,
		        properties: {
		          doctor_id: { type: :integer },
		        },
		      }

		      response '200', 'patients created' do
		        run_test!
		      end

		      response '422', 'invalid request' do
		        run_test!
		      end

		      response '404', 'invalid request' do
		        run_test!
		      end

		      response '401', 'Unauthorized' do
		        run_test!
		      end

		end
	end

	path '/api/patients/units/{unit_id}/remove_doctor' do
	    	patch 'assigne doctor to patient' do

		      tags 'Patient / Units'
		      consumes 'application/json'
		      produces 'application/json'
		      security [{ APIKeyHeader: [] }]
		      parameter name: :unit_id, in: :path, type: :integer

		      response '200', 'docotr removed' do
		        run_test!
		      end

		      response '422', 'invalid request' do
		        run_test!
		      end

		      response '404', 'not found' do
		        run_test!
		      end

		      response '401', 'Unauthorized' do
		        run_test!
		      end

	    	end
	 end

	path '/api/patients/units/{unit_id}' do
		delete 'remove unit' do

		      tags 'Patient / Units'
		      security [{ APIKeyHeader: [] }]
		      consumes 'application/json'
		      parameter name: :unit_id, in: :path, type: :integer

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

	path '/api/patients/units/{unit_id}/add_note' do
		post 'create a note' do

		      tags 'Patient / Units'
		      security [{ APIKeyHeader: [] }]
		      consumes 'application/json'
		      parameter name: :unit_id, in: :path, type: :integer
		      parameter name: :notes, in: :body, schema: {
		        type: :object,
		        properties: {
		          data: {type: :string}
		        },
		        required: [ :data ]
		      }

		      response '201', 'note created' do
		        run_test!
		      end

		      response '422', 'invalid request' do
		        run_test!
		      end

	    	end
	end

	path '/api/patients/units/{unit_id}/notes' do
		get 'get all notes for given unit unit' do

		      tags 'Patient / Units'
		      security [{ APIKeyHeader: [] }]
		      consumes 'application/json'
		      parameter name: :unit_id, in: :path, type: :integer

		      response '201', 'note created' do
		        run_test!
		      end

		      response '404', 'not found' do
		        run_test!
		      end

	    	end
	end

	path '/api/patients/units' do
	    	get 'patient units' do

		      tags 'Patient / Units'
		      security [{ APIKeyHeader: [] }]
		      consumes 'application/json'

		      response '200', 'ok' do
		        run_test!
		      end

		      response '404', 'Module not found' do
		        run_test!
		      end

		      response '422', 'invalid request' do
		        let(:patients) { }
		        run_test!
		      end
	    	end
	end
end
