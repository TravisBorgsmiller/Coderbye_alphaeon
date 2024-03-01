require 'rack'
require 'json'
require_relative 'log_requests_middleware'  # Replace with the actual file path

describe LogRequestsMiddleware do
  let(:app_response) { [200, { 'Content-Type' => 'application/json' }, ['{"response_key": "response_value"}']] }
  let(:app) { double('app', call: app_response) }
  let(:middleware) { described_class.new(app) }

  describe '#call' do
    it 'fails gracefully and does not raise JSON::ParserError for invalid JSON' do
      env = { 'HTTP_AUTHORIZATION' => 'your_authorization_header', 'PATH_INFO' => '/your_path' }
      invalid_request_body = 'invalid_json'
      request = Rack::Request.new(env.merge('rack.input' => StringIO.new(invalid_request_body)))

      allow(Rack::Request).to receive(:new).with(env).and_return(request)

      expect { middleware.call(env) }.not_to raise_error(JSON::ParserError)
    end
  end
end
