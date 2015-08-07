require 'httparty'
require 'json'
require 'yaml' if ENV['REPONAUT_ENV'] == 'cucumber'

module Reponaut
  module GitHub
    class NoSuchUserError < StandardError; end

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

      def to_s
        username
      end

      private
        def repo_data
          return mock_repo_data if ENV['REPONAUT_ENV'] == 'cucumber'
          resp = self.class.get("/users/#{username}/repos")
          raise NoSuchUserError, username if resp.code == 404
          resp.body
        end

        def mock_repo_data
          path = File.join(File.dirname(__FILE__), '..', '..', 'spec', 'fixtures', 'cassettes', "#{username}.yml")
          raw_data = IO.read(path)
          data = YAML.load(raw_data)
          raise NoSuchUserError, username if data['http_interactions'][0]['response']['status']['code'] == 404
          data['http_interactions'][0]['response']['body']['string']
        end
    end

    class Repository
      def initialize(data)
        @data = data
      end

      def fork?
        self.fork
      end

      def source?
        !fork?
      end

      def to_s
        full_name
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
