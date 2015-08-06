require 'spec_helper'
require 'reponaut/ext/hash'

module Reponaut
  module Ext
    describe Hash do
      describe '#pairs' do
        it 'returns a list of key-value pairs' do
          h = {:one => 1, :two => 2, :three => 3}
          expected = [[:one, 1], [:two, 2], [:three, 3]]
          expect(h.pairs).to eq(expected)
        end
      end
    end
  end
end
