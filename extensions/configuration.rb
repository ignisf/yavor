require 'lib/startup_config'
require 'singleton'
require 'yaml'

module Yavor
  class Configuration < Hash
    include Singleton

    def initialize
      super
      merge! YAML::load_file StartupConfig.instance.config_file
    end
  end
end
