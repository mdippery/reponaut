require 'slop'
require 'reponaut/version'

module Reponaut
  class Application
    class << self
      def run
        opts = Slop.parse do |o|
          o.banner = 'Usage: reponaut [OPTIONS] USERNAME'
          o.separator ''
          o.separator 'Options:'

          o.bool '-s', '--sort', 'Sort by repo count'
          o.bool '-f', '--ignore-forks', 'Ignore forked repos'

          o.on '-h', '--help' do
            puts o
            exit
          end

          o.on '--version' do
            puts "reponaut, version #{Reponaut::VERSION}"
            exit
          end
        end

        username = opts.arguments.first
        unless username
          puts opts
          exit 1
        end
      end
    end
  end
end
