require 'spec_helper'

module Reponaut
  describe StatisticsCalculator do
    describe '#language_counts' do
      it 'returns correct language counts' do
        VCR.use_cassette('repos') do
          gh = Reponaut::GitHub::Client.new('mdippery')
          stats = StatisticsCalculator.new(gh.repos)
          expect(stats.language_counts['Java']).to eq(2)
          expect(stats.language_counts['Objective-C']).to eq(5)
          expect(stats.language_counts['Clojure']).to eq(3)
          expect(stats.language_counts['Python']).to eq(4)
          expect(stats.language_counts['Perl']).to eq(1)
          expect(stats.language_counts['Ruby']).to eq(3)
          expect(stats.language_counts['C']).to eq(1)
          expect(stats.language_counts['VimL']).to eq(3)
          expect(stats.language_counts['JavaScript']).to eq(1)
          expect(stats.language_counts['Erlang']).to eq(1)
          expect(stats.language_counts['C++']).to eq(0)
        end
      end
    end
  end
end
