require 'reponaut/ext/hash'

module Reponaut
  module Application
    class Count < Command
      def initialize(prog)
        prog.command(:count) do |c|
          c.syntax 'count [options] <username>'
          c.description "Shows a breakdown of a user's total number of repos"
          c.option 'ignore_forks', '-f', '--ignore-forks', 'Ignore forks'
          c.option 'sort_numerically', '-n', 'Sort by number of repos instead of alphabetically'

          c.action do |args, options|
            process(options, args)
          end
        end
      end

      def process(options, args)
        super

        quit 3, "#{username} has no repositories" if repos.empty?

        stats = Reponaut::StatisticsCalculator.new(repos)
        counts = sort_counts(stats.language_counts.pairs, !!options['sort_numerically'])
        longest_label = counts.map { |e| e[0].length }.max
        longest_count = counts.map { |e| e[1].to_s.length }.max
        counts.each do |e|
          printf "%-*s     %*d\n", longest_label, e[0], longest_count, e[1]
        end
      end

      private

      def sort_counts(pairs, sort_numerically)
        sorter = sort_numerically ? NumericalSorter : LexicographicalSorter
        pairs.map { |p| sorter.new(p) }.sort.map { |s| [s.name, s.count] }
      end
    end
  end
end
