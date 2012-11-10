$LOAD_PATH << '.'

require 'rack/test'
require 'rspec'

require 'config/initializers/redis'
require 'podium/api'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before(:each) do
    $redis.flushdb
  end

  config.after(:each) do
    $redis.flushdb
  end
end
