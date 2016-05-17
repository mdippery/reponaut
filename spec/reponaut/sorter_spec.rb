require 'spec_helper'

module Reponaut
  module Application
    describe LexicographicalSorter do
      it 'sorts two wrapped pairs with the same name equally' do
        s1 = LexicographicalSorter.new(['Java', 10])
        s2 = LexicographicalSorter.new(['Java', 20])
        expect(s1 <=> s2).to eql(0)
        expect(s2 <=> s1).to eql(0)
      end

      it 'sorts two wrapped pairs with different names alphabetically' do
        s1 = LexicographicalSorter.new(['Java', 10])
        s2 = LexicographicalSorter.new(['C', 20])
        s3 = LexicographicalSorter.new(['Objective-C', 5])
        expect(s1 <=> s2).to be > 0
        expect(s2 <=> s1).to be < 0
        expect(s1 <=> s3).to be < 0
        expect(s3 <=> s1).to be > 0
        expect(s2 <=> s3).to be < 0
        expect(s3 <=> s2).to be > 0
      end

      it 'returns nil if the comparison object is not a sorter' do
        s1 = LexicographicalSorter.new(['Java', 10])
        expect(s1 <=> ['Java', 10]).to be nil
      end
    end

    describe NumericalSorter do
      it 'sorts two wrapped pairs by count descending' do
        s1 = NumericalSorter.new(['Java', 5])
        s2 = NumericalSorter.new(['C', 10])
        s3 = NumericalSorter.new(['Objective-C', 7])
        expect(s1 <=> s2).to be > 0
        expect(s2 <=> s1).to be < 0
        expect(s1 <=> s3).to be > 0
        expect(s3 <=> s1).to be < 0
        expect(s2 <=> s3).to be < 0
        expect(s3 <=> s2).to be > 0
      end

      it 'sorts two wrapped pairs with the same count by name instead' do
        s1 = NumericalSorter.new(['Java', 10])
        s2 = NumericalSorter.new(['C', 10])
        expect(s1 <=> s2).to be > 0
        expect(s2 <=> s1).to be < 0
      end

      it 'sorts two wrapped pairs that are exactly the same equally' do
        s1 = NumericalSorter.new(['Java', 10])
        s2 = NumericalSorter.new(['Java', 10])
        expect(s1 <=> s2).to eql(0)
        expect(s2 <=> s1).to eql(0)
      end

      it 'returns nil if the comparison object is not a sorter' do
        s1 = NumericalSorter.new(['Java', 10])
        expect(s1 <=> ['Java', 10]).to be nil
      end
    end
  end
end
