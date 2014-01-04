require 'yavor/extensions/configuration'

module Yavor
  describe Configuration do
    subject { Configuration.clone.instance }
    let(:test_config) { {"test_key" => "test_value"} }

    before(:each) do
      YAML.stub(:load_file).and_return(test_config)
    end

    it 'should be a singleton' do
      subject.class.should respond_to :instance
      subject.should eq Configuration.instance
    end

    it { should be_an OpenStruct }

    describe "initialization" do
      it "should load a config file" do
        test_config.each { |key, value| subject[key].should eq value }
      end
    end
  end
end
