require 'rack'

class Rack::Debug

  VERSION = '0.2.0'

  attr_reader :app

  def initialize(app, socket_path = nil)
    @socket_path = !socket_path.nil? ? File.expand_path(socket_path) : nil
    extend_ruby_debug!
    @app = app
  end

  def call(env)
    LineCache::clear_file_cache
    if @socket_path.nil?
      Debugger.start_unix_socket_remote
    else
      Debugger.start_unix_socket_remote(@socket_path)
    end
    app.call(env)
  end

private ######################################################################

  def extend_ruby_debug!
    require File.join(File.dirname(__FILE__), '..', 'rack-debug', 'debugger')
  end

end
