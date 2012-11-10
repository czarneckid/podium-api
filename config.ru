$LOAD_PATH << '.'

require 'rack'
require 'config/initializers/redis'
require 'podium/api'

run Rack::Cascade.new([
  Podium::API
])
