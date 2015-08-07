require 'spec_helper'
require 'reponaut/ext/bool'

module Reponaut
  module Ext
    describe Object do
      describe "#bool?" do
        it "is not a boolean value" do
          expect(Array.new.bool?).to be false
        end
      end
    end

    describe TrueClass do
      describe "#bool?" do
        it "is a boolean value" do
          expect(true.bool?).to be true
        end
      end
    end

    describe FalseClass do
      describe "#bool?" do
        it "is a boolean value" do
          expect(false.bool?).to be true
        end
      end
    end
  end
end
