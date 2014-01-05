require 'yavor/extensions/irc/connection'

describe Yavor::IRC::Connection do
  let(:connection) { Yavor::IRC::Connection.new '127.0.0.1', 6667 }
  before { allow_any_instance_of(Socket).to receive(:connect) }

  it 'can connect to a socket' do
    expect_any_instance_of(Socket).to receive(:connect)
    expect { connection.connect! }.to_not raise_error
  end

  describe 'reading from a socket' do
    context 'when not connected' do
      it 'raises an exception' do
        expect { connection.read }.to raise_error
      end
    end

    context 'when connected' do
      before do
        connection.connect!
        expect_any_instance_of(Socket).to receive(:gets).and_return 'text', false
      end

      it 'reads data from the socket' do
        expect(connection.read).to eq 'text'
        expect(connection.read).to eq false
      end
    end
  end

  it 'has a target host name' do
    expect(connection.host_name).to eq '127.0.0.1'
  end

  it 'has a target port' do
    expect(connection.port).to eq 6667
  end

  it 'has an SSL flag' do
    expect(connection.ssl?).to be_falsey
    expect(Yavor::IRC::Connection.new('127.0.0.1', 6697, ssl: true).ssl?).to be_truthy
  end

  it 'has a state' do
    expect(connection.state).to be :disconnected
  end
end
