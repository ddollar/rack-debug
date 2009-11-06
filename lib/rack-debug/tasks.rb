# desc "Explaining what the task does"
# task :socket_debugger do
#   # Task goes here
# end

desc 'Launch the Rack::Debug client'
task :debug do
  require File.join(File.dirname(__FILE__), 'debugger')

  begin
    Debugger.start_unix_socket_client ENV['SOCKET_PATH']
  rescue Errno::ENOENT
    puts "Server is not running or Passenger has spooled down"
  rescue StandardError => ex
    puts "Unable to connect to debugging socket: #{ex}"
  end
end
