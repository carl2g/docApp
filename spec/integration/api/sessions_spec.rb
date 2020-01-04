require 'swagger_helper'

describe 'Send a mail verify corectness of email' do
  path '/api/patient_email_confirm' do

    post 'verify email' do
      tags 'Session'
      security [{ APIKeyHeader: [] }]
      consumes 'application/json'
      parameter name: :session, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          name: { type: :string },
        },
        required: [ :email, :name ]
      }

      response '200', 'return token' do
        run_test!
      end

    end

  end
end