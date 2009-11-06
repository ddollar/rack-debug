require 'rack'

class Rack::Debug

  attr_reader :app, :options

  def initialize(app, options={})
    @app     = app
    @options = options

    extend_ruby_debug!
  end

  def call(env)
    LineCache::clear_file_cache
    Debugger.start_unix_socket_remote(socket_path)
    app.call(env)
  end

private ######################################################################

  def extend_ruby_debug!
    require File.join(File.dirname(__FILE__), '..', 'rack-debug', 'debugger')
  end

  def socket_path
    options[:socket_path]
  end

end
