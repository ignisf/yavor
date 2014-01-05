require 'simplecov'
SimpleCov.start do
  add_filter "/vendor/"
end

require 'fakefs/spec_helpers'
RSpec.configure do |config|
  config.include FakeFS::SpecHelpers, fakefs: true
end

$:.unshift "lib"
