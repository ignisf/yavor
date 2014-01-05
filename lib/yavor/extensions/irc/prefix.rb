module Yavor
  module IRC
    module Prefix
      def self.nick(nick)
        User.new nick, nil, nil
      end

      def self.user(nick, user = nil, host = nil)
        User.new nick, user, host
      end

      def self.server(server_name)
        Server.new server_name
      end

      class Server
        attr_reader :server_name

        def initialize(server_name)
          raise ArgumentError if server_name.include? ' '
          @server_name = server_name
        end

        def to_s
          ':' + @server_name
        end
      end

      class User
        attr_reader :nick, :user, :host

        def initialize(nick, user = nil, host = nil)
          if nick.nil? then raise ArgumentError.new('Nick cannot be nil')
          end

          if [nick, user, host].compact.any? { |field| field.include? ' ' }
            raise ArgumentError.new 'Space is not allowed'
          end

          @nick, @user, @host = nick, user, host
        end

        def to_s
          result  = ':' + @nick
          result += '!' + @user if @user
          result += '@' + @host if @host
          result
        end
      end
    end
  end
end
