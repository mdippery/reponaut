require 'slop'
require 'reponaut/version'

module Reponaut
  class Application
    class << self
      def run
        opts = Slop.parse do |o|
          o.on '--version' do
            puts "reponaut, version #{Reponaut::VERSION}"
            exit
          end
        end
      end
    end
  end
end
