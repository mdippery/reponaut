require 'slop'
require 'reponaut/github'
require 'reponaut/version'
require 'reponaut/ext/hash'

module Reponaut
  class Application
    class << self
      def run
        opts = Slop.parse do |o|
          o.banner = 'Usage: reponaut [OPTIONS] USERNAME [LANGUAGE]'
          o.separator ''
          o.separator 'Options:'

          o.bool '-c', '--count', 'Sort by repo count'
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
          $stderr.puts opts
          exit 1
        end

        if opts.arguments.count > 1 && opts.count?
          $stderr.puts 'Cannot pass -c when filtering by language'
          exit 2
        end

        gh = Reponaut::GitHub::Client.new(username)
        repos = gh.repos.reject { |r| r.language.nil? }
        repos = repos.find_all { |r| r.source? } if opts.ignore_forks?
        if opts.arguments.count > 1
          print_repos(username, opts.arguments[1], repos)
        else
          print_repo_counts(username, repos, opts.count?)
        end
      rescue Reponaut::GitHub::NoSuchUserError => e
        $stderr.puts "No such user: #{e}"
        exit 4
      rescue Slop::UnknownOption => e
        $stderr.puts e
        $stderr.puts 'Run `reponaut --help` for help information'
        exit 2
      end

      private

      def print_repos(username, language, repos)
        repos = repos.select { |r| r.language.downcase == language.downcase }
        if repos.empty?
          $stderr.puts "#{username} has no repositories written in #{language}"
          exit 4
        end
        repos.sort.each do |r|
          line = r.name
          line = "#{line} -> #{r.upstream}" if r.fork?
          puts line
        end
      end

      def print_repo_counts(username, repos, sort_by_count)
        if repos.count < 1
          $stderr.puts "#{username} has no repositories"
          exit 3
        end
        stats = Reponaut::StatisticsCalculator.new(repos)
        counts = stats.language_counts.pairs
        counts = if sort_by_count
                   counts.sort do |a, b|
                     res = b[1] <=> a[1]
                     if res == 0
                       a[0] <=> b[0]
                     else
                       res
                     end
                   end
                 else
                   counts.sort { |a, b| a[0] <=> b[0] }
                 end
        longest_label = counts.map { |e| e[0].length }.max
        longest_count = counts.map { |e| e[1].to_s.length }.max
        counts.each do |e|
          printf "%-*s     %*d\n", longest_label, e[0], longest_count, e[1]
        end
      end
    end
  end
end
