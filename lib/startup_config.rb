require 'ostruct'
require 'singleton'

module Yavor
  class StartupConfig < OpenStruct
    include Singleton

    DEFAULTS = {config_file: 'config.yml', daemonize: true}

    def initialize
      super DEFAULTS
      freeze
    end
  end
end
