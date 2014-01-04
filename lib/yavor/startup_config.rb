require 'singleton'
require 'slop'

module Yavor
  class StartupConfig
    def self.options
      Slop.parse do
        on 'config=', 'Configuration file', default: 'config.yml'
      end
    end
  end
end
