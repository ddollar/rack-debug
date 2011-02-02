require 'rails'
require 'rack/debug'

module RackDebug
  class Railtie < ::Rails::Railtie
    rake_tasks do
      require 'rack-debug/tasks' 
    end

    config.app_middleware.use Rack::Debug
  end
end
