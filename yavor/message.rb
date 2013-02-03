require_relative 'parameters.rb'

module Yavor
  module IRC
    class Message
      attr_reader :prefix, :command, :params

      def initialize(prefix, command, *params)
        raise ArgumentError if prefix and prefix.include?(' ')
        raise ArgumentError if command.nil? or command.include?(' ')
        @prefix, @command, @params = prefix, command, Parameters.new(*params)
      end

      def to_s
        components = [@command]
        components.unshift(':' + @prefix) if prefix
        components << @params unless @params.count == 0
        components.join ' '
      end

      def self.from_str(string)
        prefix, command, params = if string.chomp.start_with? ':'
          string.split ' ', 3
        else
          string.split(' ', 2).unshift nil
        end

        prefix[0] = '' if prefix

        if params
          params = params.split(' :', 2)
          params = params.shift.split + params
        end

        Message.new prefix, command, *params
      end
    end
  end
end
