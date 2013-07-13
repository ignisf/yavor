require 'rspec/core/rake_task'

$:.unshift "#{File.dirname(__FILE__)}/extensions/irc"

RSpec::Core::RakeTask.new do |t|
  t.ruby_opts = '-I./ -w'
end
