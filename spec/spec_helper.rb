require 'sinatra/base'
require 'rack/test'

VERBOSE = false

require_relative "../placetel.rb"

Sinatra::Application.environment = :test

RSpec.configure do |config|
  config.color_enabled = true
  config.include Rack::Test::Methods
end
