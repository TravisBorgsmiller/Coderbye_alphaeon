# Log Requests Middleware

This project includes two Ruby files related to a middleware component for logging requests and responses.

## Files

### log_requests_middleware.rb

This file contains the default implementation of the LogRequestsMiddleware class. It logs request and response details, including JSON parsing. However, if the incoming JSON is invalid, it may raise a `JSON::ParserError`, potentially disrupting the application flow.

### log_requests_middleware_improvements.rb

This file includes a simple improvement to the original middleware. It introduces error handling to make the middleware fail gracefully when JSON parsing encounters an error. Instead of raising an exception, it catches the `JSON::ParserError` and logs the error message, allowing the application to continue processing other requests.

## Testing

The primary focus of testing in these files is whether the middleware can handle valid and invalid JSON gracefully. Tests have been designed to check the behavior of the middleware in scenarios where the JSON is valid or invalid.

- `log_requests_middleware_spec.rb`: Includes tests for the default middleware to ensure it behaves correctly with valid JSON and raises errors with invalid JSON.

Run the tests to ensure that the middleware behaves as expected in different scenarios.
