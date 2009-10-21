require 'ruby-debug'
require 'socket'
require 'thread'
require 'fileutils'

module Debugger
  SOCKET_PATH = File.join(Rails.root, 'tmp', 'sockets', 'debugger')

  class << self
    def start_unix_socket_remote(socket_path=SOCKET_PATH, post_mortem = false)
      return if @thread
      return if started?

      self.interface = nil
      start
      self.post_mortem if post_mortem

      FileUtils.mkdir_p(File.dirname(socket_path))

      server_path  = "#{socket_path}.server"
      control_path = "#{socket_path}.control"

      start_unix_socket_control(control_path)

      yield if block_given?

      mutex = Mutex.new
      proceed = ConditionVariable.new

      File.unlink(server_path) if File.exists?(server_path)
      @thread = DebugThread.new do
        server = UNIXServer.open(server_path)
        while (session = server.accept)
          self.interface = RemoteInterface.new(session)
          if wait_connection
            mutex.synchronize do
              proceed.signal
            end
          end
        end
      end
      if wait_connection
        mutex.synchronize do
          proceed.wait(mutex)
        end
      end
    end
    alias_method :start_unix_socket_server, :start_unix_socket_remote

    def start_unix_socket_control(socket_path=SOCKET_PATH) # :nodoc:
      raise "Debugger is not started" unless started?
      return if defined?(@control_thread) && @control_thread
      File.unlink(socket_path) if File.exists?(socket_path)
      @control_thread = DebugThread.new do
        server = UNIXServer.open(socket_path)
        while (session = server.accept)
          interface = RemoteInterface.new(session)
          processor = ControlCommandProcessor.new(interface)
          processor.process_commands
        end
      end
    end

    def start_unix_socket_client(socket_path=SOCKET_PATH)
      require "socket"
      interface = Debugger::LocalInterface.new
      socket = UNIXSocket.new(socket_path + '.server')
      puts "Connected."

      catch(:exit) do
        while (line = socket.gets)
          case line
          when /^PROMPT (.*)$/
            input = interface.read_command($1)
            throw :exit unless input
            socket.puts input
          when /^CONFIRM (.*)$/
            input = interface.confirm($1)
            throw :exit unless input
            socket.puts input
          else
            print line
          end
        end
      end
      socket.close
    end
  end
end
