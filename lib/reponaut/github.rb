require 'httparty'
require 'json'
require 'yaml' if ENV['REPONAUT_ENV'] == 'cucumber'
require 'reponaut/ext/bool'

module Reponaut
  module GitHub
    class GitHubError < StandardError; end

    class NoSuchUserError < GitHubError; end

    class RateLimitExceededError < GitHubError; end

    class Client
      include HTTParty

      base_uri 'https://api.github.com'

      attr_reader :username

      def initialize(username)
        @username = username
      end

      def repos
        JSON.parse(repo_data).map { |e| Repository.new(self, e) }
      end

      def to_s
        username
      end

      private
        def repo_data
          return mock_repo_data if ENV['REPONAUT_ENV'] == 'cucumber'
          resp = self.class.get("/users/#{username}/repos")
          raise NoSuchUserError, username if resp.code == 404
          raise RateLimitExceededError if resp.code == 403
          resp.body
        end

        def mock_repo_data
          raise RateLimitExceededError if ENV['REPONAUT_RATE_LIMIT'] == 'on'
          path = File.expand_path("../../../spec/fixtures/cassettes/#{username}.yml", __FILE__)
          raw_data = IO.read(path)
          data = YAML.load(raw_data)
          raise NoSuchUserError, username if data['http_interactions'][0]['response']['status']['code'] == 404
          data['http_interactions'][0]['response']['body']['string']
        end
    end

    class Repository
      def initialize(service, data)
        @service = service
        @data = data
      end

      def source?
        !fork?
      end

      def upstream
        return nil unless fork?
        @service.class.get("/repos/#{full_name}")['parent']['full_name']
      end

      def to_s
        full_name
      end

      def <=>(other)
        name.downcase <=> other.name.downcase
      end

      def method_missing(symbol, *args)
        if @data.include?(symbol.to_s)
          @data[symbol.to_s]
        else
          if symbol.to_s.end_with?('?')
            bool_sym = symbol.to_s.slice(0, symbol.to_s.length-1)
            if @data.include?(bool_sym) && @data[bool_sym].bool?
              @data[bool_sym]
            else
              super
            end
          else
            super
          end
        end
      end
    end
  end
end
