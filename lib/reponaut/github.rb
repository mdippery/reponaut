require 'httparty'
require 'json'

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
        JSON.parse(self.class.get("/users/#{username}/repos").body).map { |e| Repository.new(e) }
      end
    end

    class Repository
      def initialize(data)
        @data = data
      end

      def fork?
        forks > 0
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
