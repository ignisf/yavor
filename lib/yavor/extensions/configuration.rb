require 'yavor/startup_config'
require 'ostruct'
require 'singleton'
require 'yaml'

module Yavor
  class Configuration < OpenStruct
    include Singleton

    def initialize
      super YAML::load_file StartupConfig.options[:config]
    end
  end
end
