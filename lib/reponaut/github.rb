require 'httparty'
require 'json'
require 'yaml' if ENV['REPONAUT_ENV'] == 'cucumber'
require 'reponaut/ext/bool'

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
        repo_data.map { |e| Repository.new(self, e) }
      end

      def to_s
        username
      end

      def method_missing(symbol, *args)
        if self.class.respond_to?(symbol)
          self.class.send(symbol, *args)
        else
          super
        end
      end

      private

        def real_repo_data
          resp = request_repo_data("/users/#{username}/repos")
          body = JSON.parse(resp.body)
          parse_linked_data(resp, body)
        end

        def request_repo_data(url)
          resp = get(url)
          raise NoSuchUserError, username if resp.code == 404
          raise RateLimitExceededError if resp.code == 403
          resp
        end

        def parse_linked_data(resp, acc)
          return acc unless resp.headers.include?('link')
          links = resp.headers['link'].split(/,/).map { |l| l.strip }
          next_url = links.find { |l| l =~ link_url_re }
          return acc unless next_url
          next_url = next_url.match(link_url_re).captures.first
          resp = request_repo_data(next_url)
          acc += JSON.parse(resp.body)
          parse_linked_data(resp, acc)
        end

        def link_url_re
          /^<(.+)>; rel="next"$/
        end

        def mock_repo_data
          raise RateLimitExceededError if ENV['REPONAUT_RATE_LIMIT'] == 'on'
          path = File.expand_path("../../../spec/fixtures/cassettes/#{username}.yml", __FILE__)
          raw_data = IO.read(path)
          data = YAML.load(raw_data)
          raise NoSuchUserError, username if data['http_interactions'][0]['response']['status']['code'] == 404
          JSON.parse(data['http_interactions'][0]['response']['body']['string'])
        end

        define_method(:repo_data, instance_method(ENV.cucumber? ? :mock_repo_data : :real_repo_data))
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
        repo_data['parent']['full_name']
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

      private

      def real_repo_data
        @service.get("/repos/#{full_name}")
      end

      def mock_repo_data
        path = File.expand_path("../../../spec/fixtures/repos/#{full_name}.json", __FILE__)
        raw_data = IO.read(path)
        JSON.parse(raw_data)
      end

      define_method(:repo_data, instance_method(ENV.cucumber? ? :mock_repo_data : :real_repo_data))
    end

    class GitHubError < StandardError; end

    class NoSuchUserError < GitHubError; end

    class RateLimitExceededError < GitHubError; end
  end
end
