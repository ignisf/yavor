require 'lib/startup_config'

module Yavor
  describe StartupConfig do
    describe '::options' do
      it 'should point to a default configuration file' do
        StartupConfig.options[:config].should eq 'config.yml'
      end

      it 'should parse command line options' do
        stub_const 'ARGV', ['--config=kancho.yml']
        StartupConfig.options[:config].should eq 'kancho.yml'
      end
    end
  end
end
