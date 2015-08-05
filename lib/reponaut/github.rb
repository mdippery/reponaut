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
        JSON.parse(self.class.get("/users/#{username}/repos").body)
      end
    end
  end
end
