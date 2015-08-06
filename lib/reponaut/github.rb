require 'httparty'
require 'json'
require 'yaml' if ENV['REPONAUT_ENV'] == 'cucumber'

module Reponaut
  module GitHub
    class Client
      include HTTParty

      base_uri 'https://api.github.com'

      attr_reader :username

      def initialize(username)
        @username = username
      end

      def repos
        JSON.parse(repo_data).map { |e| Repository.new(e) }
      end

      private
        def repo_data
          return mock_repo_data if ENV['REPONAUT_ENV'] == 'cucumber'
          self.class.get("/users/#{username}/repos").body
        end

        def mock_repo_data
          path = File.join(File.dirname(__FILE__), '..', '..', 'spec', 'fixtures', 'cassettes', 'repos.yml')
          raw_data = IO.read(path)
          data = YAML.load(raw_data)
          data['http_interactions'][0]['response']['body']['string']
        end
    end

    class Repository
      def initialize(data)
        @data = data
      end

      def fork?
        forks > 0
      end

      def source?
        !fork?
      end

      def method_missing(symbol, *args)
        if @data.include?(symbol.to_s)
          @data[symbol.to_s]
        else
          super
        end
      end
    end
  end
end
