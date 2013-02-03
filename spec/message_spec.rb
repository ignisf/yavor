require 'rspec'
require './yavor/message.rb'

module Yavor
  module IRC
    describe Message do
      let(:prefix) { 'some_prefix' }
      let(:command) { 'some_command' }
      let(:params) { ['param1', 'param2', ':multiword param'] }
      let(:string) { ':some_prefix some_command param1 param2 :multiword param' }
      let(:message) { Message.new prefix, command, *params }

      it 'has the needed accessors' do
        expect { message.prefix = 'alabala' }.to_not raise_error
        expect { message.command = 'command' }.to_not raise_error
        expect { message.params = ['1', '2', '3'] }.to_not raise_error

        message.prefix.should eq 'alabala'
        message.command.should eq 'command'
        message.params.should eq ['1', '2', '3']
      end

      it 'validates the prefix and the command' do
        expect { message.prefix = 'space jam' }.to raise_error
        expect { message.command = 'go home' }.to raise_error
      end

      context 'when initialized with a prefix' do
        subject { Message.new prefix, command, *params }
        its(:to_s) { should eq ":#{prefix} #{command} #{params.join ' '}" }
      end

      context 'when initialized without a prefix' do
        subject { Message.new nil, command, *params }
        its(:to_s) { should eq "#{command} #{params.join ' '}" }
      end
    end
  end
end
