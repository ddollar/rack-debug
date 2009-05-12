# desc "Explaining what the task does"
# task :socket_debugger do
#   # Task goes here
# end

task :debug do
  require File.join(File.dirname(__FILE__), '..', 'ext', 'debugger')
  Debugger.start_unix_socket_client
end
