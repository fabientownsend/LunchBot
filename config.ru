require './lib/auth'
require './lib/event_controller'
require 'data_mapper'
require 'dm-core'

require 'raven'
require 'logglier'

Raven.configure do |config|
  config.dsn = ENV['SENTRY_URL']
end

config.logger = Logglier.new(ENV['LOGGLIER_URL'], :threaded => true)

use Raven::Rack

DataMapper.setup(:default, ENV['DATABASE_URL'])
DataMapper.finalize.auto_upgrade!
DataMapper::Property::String.length(255)

# Initialize the app and create the API (bot) and Auth objects.
run Rack::Cascade.new [EventController, Auth]
$stdout.sync = true
