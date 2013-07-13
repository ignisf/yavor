require 'singleton'
require 'yaml'

module Yavor
  class Configuration < Hash
    include Singleton

    DEFAULT_CONFIG_FILE = './config.yml'

    def initialize
      super
      merge! YAML::load_file DEFAULT_CONFIG_FILE
    end
  end
end
