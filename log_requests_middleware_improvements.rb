require 'rack'
require 'json'

class LogRequestsMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)
    request = Rack::Request.new(env)
    request_body = request.body.read
    log_request_and_response!(request: request_body, headers: env["HTTP_AUTHORIZATION"], url: request.path, response: response.first)

    [status, headers, response]
  end

  def log_request_and_response!(request:, headers:, url:, response:)
    return if ['swagger', 'favicon.ico'].include?(url)

    begin
      request = JSON.parse(request) unless request.empty?
      response = JSON.parse(response) unless response.empty?
      Log.create!(
        request: request,
        headers: headers,
        url: url,
        response: response
      )
    rescue JSON::ParserError => e
      # Log the error and handle it gracefully
      log_json_parsing_error(e)
    end
  end

  def log_json_parsing_error(error)
    # Log the JSON parsing error or perform other error-handling actions
    puts "Failed to parse JSON: #{error.message}"
  end
end