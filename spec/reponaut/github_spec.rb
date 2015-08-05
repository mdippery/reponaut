require 'spec_helper'

module Reponaut
  module GitHub
    describe Client do
      let(:github) { Client.new('mdippery') }

      describe '#repos' do
        it "returns the user's repos" do
          VCR.use_cassette('repos') do
            expect(github.repos.count).to eq(24)
          end
        end

        it 'returns a valid repo name for a repo' do
          VCR.use_cassette('repos') do
            expect(github.repos[0].full_name).to eq('mdippery/3ddv')
          end
        end

        it 'returns a valid language for a repo' do
          VCR.use_cassette('repos') do
            expect(github.repos[0].language).to eq('Java')
          end
        end
      end
    end
  end
end