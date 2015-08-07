require 'slop'
require 'reponaut/github'
require 'reponaut/version'
require 'reponaut/ext/hash'

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
          $stderr.puts opts
          exit 1
        end

        gh = Reponaut::GitHub::Client.new(username)
        repos = gh.repos.reject { |r| r.language.nil? }
        repos = repos.find_all { |r| r.source? } if opts.ignore_forks?
        if repos.count < 1
          $stderr.puts "#{username} has no repositories"
          exit 3
        end
        stats = Reponaut::StatisticsCalculator.new(repos)
        counts = stats.language_counts.pairs
        counts = if opts.sort?
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
      rescue Slop::UnknownOption => e
        $stderr.puts e
        $stderr.puts 'Run `reponaut --help` for help information'
        exit 2
      end
    end
  end
end
