require 'rspec'
require './yavor/message.rb'

module Yavor
  module IRC
    describe Message do
      let(:prefix) { 'some_prefix' }
      let(:command) { 'some_command' }
      let(:params) { ['param1', 'param2', 'multiword param'] }
      let(:string) { ':some_prefix some_command param1 param2 :multiword param' }
      let(:message) { Message.new prefix, command, *params }

      it 'has the needed readers' do
        message.prefix.should eq prefix
        message.command.should eq command
        message.params.should eq Parameters.new(*params)
      end

      it 'is immutable' do
        expect { message.prefix = 'alabala' }.to raise_error
        expect { message.command = 'command' }.to raise_error
        expect { message.params = ['1', '2', '3'] }.to raise_error
      end

      it 'validates the prefix and the command' do
        expect { message.prefix = 'space jam' }.to raise_error
        expect { message.command = 'go home' }.to raise_error
      end

      context 'when initialized with a prefix' do
        subject { Message.new prefix, command, *params }
        its(:to_s) { should eq string }
      end

      context 'when initialized without a prefix' do
        subject { Message.new nil, command, *params }
        its(:to_s) { should eq "#{command} #{params[0]} #{params[1]} :#{params[2]}" }
      end

      describe '#from_str' do
        it 'parses a multi-word-parameter-only message' do
          message = Message.from_str ':asd 001 :test asdf'
          #message.params.count.should eq 1
          message.params.first.should eq 'test asdf'
        end
        it 'parses long messages' do
          message = Message.from_str ':ludost.net 001 fuck_off :Welcome to the whatever Internet Relay Chat Network fuck_off'
          message.prefix.should eq 'ludost.net'
          message.command.should eq '001'
          message.params[0].should eq 'fuck_off'
          message.params[1].should eq 'Welcome to the whatever Internet Relay Chat Network fuck_off'

          message = Message.from_str ':ludost.net 005 fuck_off CHANTYPES=&# EXCEPTS INVEX CHANMODES=eIb,k,l,imnpstS CHANLIMIT=&#:15 PREFIX=(ov)@+ MAXLIST=beI:25 MODES=4 NETWORK=whatever KNOCK STATUSMSG=@+ CALLERID=g :are supported by this server'
          message.params.count.should eq 14
          message.params[7].should eq 'MAXLIST=beI:25'

          message = Message.from_str ':GLOBAL!global@services.int NOTICE fuck_off :Welcome to the ludost.net irc network. Enjoy your stay and behave :)'
          message.params[1].should eq 'Welcome to the ludost.net irc network. Enjoy your stay and behave :)'
        end
      end
    end
  end
end
