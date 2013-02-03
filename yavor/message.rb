require_relative 'parameters.rb'

module Yavor
  module IRC
    class Message
      attr_reader :prefix, :command, :params

      def initialize(prefix, command, *params)
        raise ArgumentError if prefix and prefix.include?(' ')
        raise ArgumentError if command.include?(' ')
        @prefix, @command, @params = prefix, command, Parameters.new(*params)
      end

      def to_s
        components = [@command, @params]
        components.unshift(':' + @prefix) if prefix
        components.join ' '
      end

      def self.from_str(string)
        prefix, command, params = if string.start_with? ':'
          string.split ' ', 3
        else
          string.split(' ', 2).unshift nil
        end

        prefix[0] = '' if prefix

        if params
          single_word, _, multi_word = params.rpartition(' :')
          params = single_word.split << multi_word
        end

        Message.new prefix, command, *params
      end
    end
  end
end
