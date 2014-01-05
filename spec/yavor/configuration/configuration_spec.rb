require 'yavor/extensions/configuration'

module Yavor
  describe Configuration, fakefs: true do
    before(:each) do
      File.open('config.yml', 'w') do |f|
        f.puts({"test_key" => "test_value"}.to_yaml)
      end
    end

    subject { Configuration.clone.instance }

    it 'should be a singleton' do
      expect(subject.class).to respond_to :instance
      expect(subject).to eq Configuration.instance
    end

    it { should be_an OpenStruct }

    describe "initialization" do
      it "should load a config file" do
        expect(subject.test_key).to eq "test_value"
      end
    end
  end
end
