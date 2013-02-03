require 'enumerator'
require 'forwardable'

module Yavor
  module IRC
    class Parameters
      include Enumerable
      extend Forwardable

      def initialize(*params)
        raise ArgumentError if params[0...-1].any? { |param| param.include? ' ' }
        @params = params
      end

      def to_s
        @params.last.prepend(':') if @params.last and @params.last.include? ' '
        @params.join ' '
      end

      def_delegator :@params, :[]
      def_delegator :@params, :each
    end
  end
end
