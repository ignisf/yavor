require 'rspec'
require_relative '../prefix.rb'

module Yavor
  module IRC
    describe Prefix do
      describe '::nick' do
        it 'should return a prefix initialized with a nick' do
          Prefix.nick('test').nick.should eq 'test'
        end
      end

      describe '::user' do
        it 'should return a prefix initialized with nick, ident and a host' do
          prefix = Prefix.user 'testnick', 'testuser', nil
          prefix.nick.should eq 'testnick'
          prefix.user.should eq 'testuser'
          prefix.host.should eq nil
        end
      end

      describe '::server' do
        it 'should create a server prefix' do
          Prefix.server('useless.com').server_name.should eq 'useless.com'
        end
      end
    end

    module Prefix
      describe Server do
        subject { Server.new server_name }
        let(:server_name) { 'server_name123.com' }

        describe "initialization" do
          context 'with a valid server name' do
            it 'succeedes' do
              expect { Server.new server_name }.to_not raise_error
            end
          end

          context 'with an invalid server name' do
            it 'fails' do
              expect { Server.new 'not_so valid.com' }.to raise_error ArgumentError
            end
          end
        end

        its(:server_name) { should eq server_name }
        its(:to_str) { should eq ':' + server_name }
        its(:to_s) { should eq subject.to_str }
      end

      describe User do
        subject { User.new nick, user, host }
        let(:nick) { 'yanko' }
        let(:user) { 'ignatov' }
        let(:host) { 'useless.com' }

        describe 'initialization' do
          context 'with valid data' do
            it 'succeedes' do
              expect { User.new nick, user, host }.to_not raise_error
            end
          end

          context 'with invalid data' do
            it 'fails' do
              expect { User.new 'ni ck', 'user', 'host' }.to raise_error ArgumentError
              expect { User.new 'nick', 'us er', 'host' }.to raise_error ArgumentError
              expect { User.new 'nick', 'user', 'ho st' }.to raise_error ArgumentError
              expect { User.new nil, 'user', 'host' }.to raise_error ArgumentError
              expect { User.new }.to raise_error ArgumentError
            end
          end
        end

        its(:nick) { should eq nick }
        its(:user) { should eq user }
        its(:host) { should eq host }
        its(:to_s) { should eq subject.to_str }

        describe '#to_str' do
          context 'when initialized with a nick, user and a host' do
            it "should construct a string representation with all of them" do
              subject.to_str.should eq ":#{nick}!#{user}@#{host}"
            end
          end

          context 'when initializes with a nick and a host' do
            let(:user) { nil }

            it 'should construct a string representation with nick and a host' do
              subject.to_str.should eq ":#{nick}@#{host}"
            end
          end

          context 'when initializes with a nick and a user' do
            let(:host) { nil }

            it 'should construct a string representation with nick and a user' do
              subject.to_str.should eq ":#{nick}!#{user}"
            end
          end
        end
      end
    end
  end
end
