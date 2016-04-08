require 'spec_helper'

module Reponaut
  module GitHub
    describe Client do
      let(:username) { 'mdippery' }
      let(:github) { Client.new(username) }

      describe '#repos' do
        it "returns the user's repos" do
          VCR.use_cassette(username) do
            expect(github.repos.count).to eq(24)
          end
        end

        it 'returns a valid repo name for a repo' do
          VCR.use_cassette(username) do
            expect(github.repos[0].full_name).to eq('mdippery/3ddv')
          end
        end

        it 'returns a valid language for a repo' do
          VCR.use_cassette(username) do
            expect(github.repos[0].language).to eq('Java')
          end
        end
      end
    end

    describe Repository do
      let (:username) { 'mdippery' }
      let (:github) { Client.new(username) }

      describe '#fork?' do
        it 'returns true if the repository is a fork' do
          VCR.use_cassette(username) do
            repo = github.repos.find { |r| r.full_name == 'mdippery/dnsimple-python' }
            expect(repo.fork?).to be true
          end
        end

        it 'returns false if the repository is not a fork' do
          VCR.use_cassette(username) do
            repo = github.repos.find { |r| r.full_name == 'mdippery/chameleon' }
            expect(repo.fork?).to be false
          end
        end
      end

      describe '#source?' do
        it 'returns true if the repository is a source' do
          VCR.use_cassette(username) do
            repo = github.repos.find { |r| r.full_name == 'mdippery/chameleon' }
            expect(repo.source?).to be true
          end
        end

        it 'returns false if the repository is not a source' do
          VCR.use_cassette(username) do
            repo = github.repos.find { |r| r.full_name == 'mdippery/dnsimple-python' }
            expect(repo.source?).to be false
          end
        end
      end

      describe '#upstream' do
        it 'returns nil if the repository is not a fork' do
          VCR.use_cassette(username) do
            repo = github.repos.find { |r| r.full_name == 'mdippery/chameleon' }
            expect(repo.upstream).to be nil
          end
        end

        it 'returns a string representing the source repository if the repo is a fork' do
          VCR.use_cassette(username) do
            repo = github.repos.find { |r| r.full_name == 'mdippery/dnsimple-python' }
            VCR.use_cassette(repo.name) do
              expect(repo.upstream).to eq('mikemaccana/dnsimple-python')
            end
          end
        end
      end

      describe '#<=>' do
        it 'sorts repositories lexicographically by name' do
          VCR.use_cassette(username, :allow_playback_repeats => true) do
            r1 = github.repos.find { |r| r.full_name == 'mdippery/chameleon' }
            r2 = github.repos.find { |r| r.full_name == 'mdippery/dnsimple-python' }
            expect(r1 <=> r2).to eq(-1)
            expect(r2 <=> r1).to eq(1)
            expect(r1 <=> r1).to eq(0)
          end
        end

        it 'ignores case when sorting' do
          VCR.use_cassette(username, :allow_playback_repeats => true) do
            r1 = github.repos.find { |r| r.full_name == 'mdippery/nginx.vim' }
            r2 = github.repos.find { |r| r.full_name == 'mdippery/Smyck-Color-Scheme' }
            expect(r1 <=> r2).to eq(-1)
            expect(r2 <=> r1).to eq(1)
            expect(r1 <=> r1).to eq(0)
          end
        end
      end
    end
  end
end
