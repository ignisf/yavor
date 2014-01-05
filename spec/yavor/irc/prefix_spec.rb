require 'yavor/extensions/irc/prefix'

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
        let(:server) { Server.new 'irc.ludost.net' }

        describe "initialization" do
          it 'validates the server name' do
            expect { Server.new 'irc.ludost.net' }.to_not raise_error
            expect { Server.new 'not_so valid.com' }.to raise_error ArgumentError
          end
        end

        it 'has a name' do
          server.server_name.should eq 'irc.ludost.net'
        end

        describe '#to_s' do
          it 'returns a standards-compliant string representation' do
            server.to_s.should eq ":#{server.server_name}"
          end
        end
      end

      describe User do
        subject { User.new nick, user, host }
        let(:nick) { 'yanko' }
        let(:user) { 'ignatov' }
        let(:host) { 'useless.com' }

        describe 'initialization' do
          it 'validates the user data' do
            expect { User.new nick, user, host }.to_not raise_error
            expect { User.new 'ni ck', 'user', 'host' }.to raise_error ArgumentError
            expect { User.new 'nick', 'us er', 'host' }.to raise_error ArgumentError
            expect { User.new 'nick', 'user', 'ho st' }.to raise_error ArgumentError
            expect { User.new nil, 'user', 'host' }.to raise_error ArgumentError
            expect { User.new }.to raise_error ArgumentError
          end
        end

        it 'has a nick' do
          subject.nick.should eq nick
        end

        it 'has a user' do
          subject.user.should eq user
        end

        it 'has a host' do
          subject.host.should eq host
        end

        describe '#to_s' do
          context 'when initialized with a nick, user and a host' do
            it "contains all of them" do
              subject.to_s.should eq ":#{nick}!#{user}@#{host}"
            end
          end

          context 'when initialized with a nick and a host' do
            let(:user) { nil }

            it 'contains only a nick and a host' do
              subject.to_s.should eq ":#{nick}@#{host}"
            end
          end

          context 'when initialized with a nick and a user' do
            let(:host) { nil }

            it 'contains only a nick and a user' do
              subject.to_s.should eq ":#{nick}!#{user}"
            end
          end
        end
      end
    end
  end
end
