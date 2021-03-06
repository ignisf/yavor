require 'yavor/extensions/irc/parameters'

module Yavor
  module IRC
    describe Parameters do
      subject { Parameters.new(*params) }
      let(:params) { ['para1', 'para2', 'para 3'] }

      it 'can be initialized' do
        expect { Parameters.new 'para1', 'para2', 'para 3' }.to_not raise_error
      end

      it 'provides access to parameters by index' do
        expect(subject[1]).to eq 'para2'
      end

      it 'is immutable' do
        expect { subject[0]='ninja turtle' }.to raise_error
        expect { subject[3]='oops' }.to raise_error
      end

      describe 'enumeration' do
        it { should respond_to :each, :count, :each_cons, :each_with_index, :map, :inject, :any?, :all? }

        context 'when initialized with an empty parameter list' do
          let(:params) { [] }

          it 'yields nothing' do
            subject.each { fail }
          end
        end
      end

      describe 'validation' do
        it 'raises an error when the multiword parameter isn\'t last' do
          expect { Parameters.new 'para 1', 'para2' }.to raise_error
        end
      end

      describe 'comparisson' do
        it { should eq Parameters.new(*params) }
        it { should_not eq Parameters.new('1', '2', '3') }
        it { should_not eq [1, 2, 3] }

        context 'when no parameters' do
          let(:params) { [] }
          it { should eq Parameters.new }
        end
      end

      describe 'string representation' do
        context 'when there are no parameters' do
          let(:params) { [] }

          it 'is an empty string' do
            expect(subject.to_s).to eq ''
          end
        end

        context 'with only single-word parameters' do
          let(:params) { %w(a b c d e f g h i sadf) }

          it 'consists of the parameters separated by spaces' do
            expect(subject.to_s).to eq params.join(' ')
          end
        end

        context 'with a multi-word parameter' do
          let(:params) { ['a', 'b', 'asdf asdf'] }

          it 'ends with the multi-word parameter separated with a colon' do
            expect(subject.to_s).to eq 'a b :asdf asdf'
          end
        end
      end
    end
  end
end
