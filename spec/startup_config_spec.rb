require 'lib/startup_config'

module Yavor
  describe StartupConfig do
    subject { StartupConfig.clone.instance }

    it { should be_an OpenStruct }

    it 'should be a singleton' do
      subject.class.should respond_to :instance
      subject.should eq subject.class.instance
    end

    it { should be_frozen }

    describe 'initialization' do
      before(:each) do
        stub_const 'Yavor::StartupConfig::DEFAULTS', {foo: 'bar', stefi: 'kancho'}
        stub_const 'ARGV', ['--lol', 'wut']
      end

      it 'should assign default values' do        
        subject.foo.should eq 'bar'
        subject.stefi.should eq 'kancho'
      end

      it 'should parse command line arguments'
    end

    describe 'default values' do
      its(:config_file) { should_not be_nil }
      its(:daemonize) { should_not be_nil }
    end
  end
end
