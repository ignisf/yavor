require 'rspec'
require_relative '../parameters.rb'

module Yavor
  module IRC
    describe Parameters do
      it 'can be initialized' do
        expect { Parameters.new 'para1', 'para2', 'para 3' }.to_not raise_error
      end

      describe 'enumeration' do
        it 'responds to each, map, count, etc.' do
          parameters = new_params 'para1'
          [:each, :count, :each_cons, :each_with_index, :map, :inject, :any?, :all?].each do |enumerable_method|
            parameters.should respond_to(enumerable_method)
          end
        end

        it 'yealds nothing for empty paramter lists' do
          new_params.each { fail }
        end

        it 'provides access to the parameters' do
          params = new_params('para1', 'para2', 'para3')
          params[1].should eq 'para2'
        end

        it 'cannot be mutated' do
          params = new_params('para1')
          expect { params[0]='ninja turtle' }.to raise_error
          expect { params[3]='oops' }.to raise_error
        end
      end

      describe 'validation' do
        it 'raises an error when the multiword parameter isn\'t last' do
          expect { new_params 'para 1', 'para2' }.to raise_error
        end
      end

      describe 'comparisson' do
        it 'can be compared to other parameter lists' do
          new_params('1', '2', '3').should eq new_params('1', '2', '3')
          new_params.should eq new_params
          new_params.should_not eq new_params('1', '2', '3')
        end
      end

      describe 'string representation' do
        it 'is an empty string when there are no parameters' do
          new_params.to_s.should eq ''
        end

        it 'has no colon when there are only single-world parameters' do
          new_params('para1', 'para2').to_s.should eq 'para1 para2'
        end

        it 'has a colon before the multiword parameter' do
          new_params('para1', 'para2', 'para 3').to_s.should eq 'para1 para2 :para 3'
          new_params('para 1').to_s.should eq ':para 1'
        end
      end
    end
  end
end

def new_params(*params)
  Yavor::IRC::Parameters.new(*params)
end
