# Change back to 10 when in production.
# Rack::Timeout.timeout = (ENV["RACK_TIMEOUT"] || 10).to_i
Rack::Timeout.timeout = (ENV["RACK_TIMEOUT"] || 1000).to_i
