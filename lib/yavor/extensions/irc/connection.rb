require 'event_bus'
require 'forwardable'

module Yavor
  module IRC
    class Connection
      attr_reader :server, :state

      extend Forwardable
      def_delegators :@server, :host_name, :port

      def initialize(host_name, port, options = {})
        @server, @options = Server.new(host_name, port), options
        @state = :disconnected
      end

      def ssl?
        @options[:ssl]
      end

      def connect!
        @server.each_address do |address|
          @socket = address.connect
          @socket.close
        end
      end

      def read
        @socket.gets
      end

      class Server
        attr_reader :host_name, :port

        def initialize(host_name, port)
          @host_name, @port= host_name, port
        end

        def addresses
          Addrinfo.getaddrinfo @host_name, @port, nil, :STREAM
        end

        def each_address(&block)
          addresses.each(&block)
        end
      end
    end
  end
end
