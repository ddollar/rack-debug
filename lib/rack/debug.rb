require 'rack'

class Rack::Debug

  VERSION = '0.1.0'

  attr_reader :app

  def initialize(app, options={})
    @app = app
    instance_eval(&block) if block_given?
  end

  def call(env)
    Debugger.start_unix_socket_remote if debug?
    app.call(env)
  end

private ######################################################################

  def debug?
    return true if RAILS_ENV == 'development'
  end

end
