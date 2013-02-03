require_relative 'parameters.rb'

module Yavor
  module IRC
    def split_first_word(string)
      string.split(' ', 2).first
    end

    class Message
      attr_reader :prefix, :command, :params

      def initialize(prefix, command, *params)
        raise ArgumentError if prefix and prefix.include?(' ')
        raise ArgumentError if command.include?(' ')
        @prefix, @command, @params = prefix, command, Parameters.new(params)
      end

      def to_s
        components = [@command, @params]
        components.unshift(':' + @prefix) if prefix
        components.join ' '
      end

      def self.from_str(string)
        prefix, command, params = if string.starts_with ':'
          string.split ' ', 3
        else
          string.split(' ', 2).unshift nil
        end

        prefix[0] = '' if prefix

        params = params.split(':', 2)
        params[1][0] = '' if params[1]
        params = params.shift.split + params

        Message.new prefix, command, Parameters.new(*params)
      end
    end
  end
end
