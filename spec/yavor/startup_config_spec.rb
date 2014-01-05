require 'yavor/startup_config'

module Yavor
  describe StartupConfig do
    describe '::options' do
      it 'should point to a default configuration file' do
        expect(StartupConfig.options[:config]).to eq 'config.yml'
      end

      it 'should parse command line options' do
        stub_const 'ARGV', ['--config=kancho.yml']
        expect(StartupConfig.options[:config]).to eq 'kancho.yml'
      end
    end
  end
end
