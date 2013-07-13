require 'lib/startup_config'
require 'ostruct'
require 'singleton'
require 'yaml'

module Yavor
  class Configuration < OpenStruct
    include Singleton

    def initialize
      super YAML::load_file StartupConfig.instance.config_file
    end
  end
end
