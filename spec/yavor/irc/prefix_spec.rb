require 'yavor/extensions/irc/prefix'

module Yavor
  module IRC
    describe Prefix do
      describe '::nick' do
        it 'initializes a nick prefix' do
          expect(Prefix.nick('test').nick).to eq 'test'
        end
      end

      describe '::user' do
        it 'initializes a prefix with nick, ident and a host' do
          prefix = Prefix.user 'testnick', 'testuser', nil
          expect(prefix.nick).to eq 'testnick'
          expect(prefix.user).to eq 'testuser'
          expect(prefix.host).to eq nil
        end
      end

      describe '::server' do
        it 'initializes a server prefix' do
          expect(Prefix.server('useless.com').server_name).to eq 'useless.com'
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
          expect(server.server_name).to eq 'irc.ludost.net'
        end

        describe '#to_s' do
          it 'returns a standards-compliant string representation' do
            expect(server.to_s).to eq ":#{server.server_name}"
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
          expect(subject.nick).to eq nick
        end

        it 'has a user' do
          expect(subject.user).to eq user
        end

        it 'has a host' do
          expect(subject.host).to eq host
        end

        describe '#to_s' do
          context 'when initialized with a nick, user and a host' do
            it "contains all of them" do
              expect(subject.to_s).to eq ":#{nick}!#{user}@#{host}"
            end
          end

          context 'when initialized with a nick and a host' do
            let(:user) { nil }

            it 'contains only a nick and a host' do
              expect(subject.to_s).to eq ":#{nick}@#{host}"
            end
          end

          context 'when initialized with a nick and a user' do
            let(:host) { nil }

            it 'contains only a nick and a user' do
              expect(subject.to_s).to eq ":#{nick}!#{user}"
            end
          end
        end
      end
    end
  end
end
