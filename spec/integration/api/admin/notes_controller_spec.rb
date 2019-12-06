require 'swagger_helper'

describe 'edit a note' do
  path '/api/admins/notes/{id}' do

    patch 'edit note when admin' do
	    tags 'Admin'
	    security [{ APIKeyHeader: [] }]
	    consumes 'application/json'
		parameter name: :id, in: :path, type: :integer
	    parameter name: :note, in: :body, schema: {
	        type: :object,
	        properties: {
	          data: { type: :json },
	        },
	        required: [ :id, :name, :data, :unit_id]
	    }

	    response '200', 'return token' do
	        run_test!
	    end
	end

  end
end