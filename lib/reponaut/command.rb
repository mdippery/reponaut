module Reponaut
  module Application
    class Command
      class << self
        def subclasses
          @subclasses ||= []
        end

        def inherited(base)
          subclasses << base
          super
        end
      end

      attr_reader :username, :client, :repos

      def initialize(prog)
      end

      def process(options, args)
        raise ArgumentError.new('You must specify a username') if args.empty?
        @username = args.first
        @client = Reponaut::GitHub::Client.new(username)
        @repos = client.repos.reject { |r| r.language.nil? }
        @repos = @repos.find_all { |r| r.source? } if options['ignore_forks']
      rescue Reponaut::GitHub::NoSuchUserError
        quit 4, "No such user: #{username}"
      rescue Reponaut::GitHub::RateLimitExceededError
        quit 5, 'GitHub rate limit exceeded. Try your request again later.'
      end

      def quit(code, msg)
        $stderr.puts msg
        exit code
      end
    end
  end
end
