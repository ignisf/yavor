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
        if @params.last and @params.last.include? ' '
          (@params[0...-1] << ':' + @params.last).join ' '
        else
          @params.join ' '
        end
      end

      def ==(other)
        if other.kind_of? Parameters and other.count == count
          @params.map.with_index.all? { |value, index| value == other[index] }
        else
          false
        end
      end

      def_delegator :@params, :[]
      def_delegator :@params, :each
    end
  end
end
