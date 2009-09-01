require 'rack'

class Rack::Debug

  VERSION = '0.1.0'

  attr_reader :app

  def initialize(app, options={})
    extend_ruby_debug!
    @app = app
  end

  def call(env)
    LineCache::clear_file_cache
    Debugger.start_unix_socket_remote
    app.call(env)
  end

private ######################################################################

  def extend_ruby_debug!
    require File.join(File.dirname(__FILE__), '..', '..', 'ext', 'debugger')
  end

end
