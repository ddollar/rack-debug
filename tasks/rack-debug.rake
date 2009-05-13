# desc "Explaining what the task does"
# task :socket_debugger do
#   # Task goes here
# end

task :debug do
  require File.join(File.dirname(__FILE__), '..', 'ext', 'debugger')

  begin
    Debugger.start_unix_socket_client
  rescue Errno::ENOENT
    puts "Server is not running or Passenger has spooled down"
  rescue StandardError => ex
    puts "Unable to connect to debugging socket: #{ex}"
  end
end
