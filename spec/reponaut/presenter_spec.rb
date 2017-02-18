require 'spec_helper'

module Reponaut
  module Application
    describe 'Presenters' do
      let (:repo) { double('repo', :name => '3ddv',
                                   :description => 'NEES 3D Data Viewer from the Center for Earthquake Engineering Simulation at RPI',
                                   :fork? => false,
                                   :language => 'Java') }
      let (:fork) { double('repo', :name => 'mercenary',
                                   :description => 'An easier way to build your command-line scripts in Ruby.',
                                   :fork? => true,
                                   :upstream => 'jekyll/mercenary',
                                   :language => 'Ruby') }

      describe SimplePresenter do
        let (:formatter) { SimplePresenter.new }

        it "prints the repo's name" do
          expect(formatter.format(repo)).to eq('3ddv')
        end

        it "prints the name of the upstream repo if the repo is a fork" do
          expect(formatter.format(fork)).to eq('mercenary -> jekyll/mercenary')
        end
      end

      describe LanguagePresenter do
        let (:formatter) { LanguagePresenter.new }

        it "prints the repo's name and language" do
          expect(formatter.format(repo)).to eq('3ddv [Java]')
        end

        it "prints the repo's name and language and the name of the upstream repo if the repo is a fork" do
          expect(formatter.format(fork)).to eq('mercenary -> jekyll/mercenary [Ruby]')
        end
      end

      describe LongPresenter do
        let (:formatter) { LongPresenter.new }

        it "prints the repo's name and description" do
          expected = <<EOS.chomp
3ddv
    NEES 3D Data Viewer from the Center for Earthquake Engineering Simulation at RPI
EOS
          expect(formatter.format(repo)).to eq(expected)
        end

        it "prints the repo's name, description, and upstream repo's name if the repo is a fork" do
          expected = <<EOS.chomp
mercenary -> jekyll/mercenary
    An easier way to build your command-line scripts in Ruby.
EOS
          expect(formatter.format(fork)).to eq(expected)
        end

        it 'separates multiple repo listings with a blank line' do
          expected = <<EOS.chomp
3ddv
    NEES 3D Data Viewer from the Center for Earthquake Engineering Simulation at RPI

mercenary -> jekyll/mercenary
    An easier way to build your command-line scripts in Ruby.
EOS
          actual = formatter.format(repo) + "\n" + formatter.format(fork)
          expect(actual).to eq(expected)
        end
      end
    end
  end
end
