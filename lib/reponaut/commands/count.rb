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
        counts = stats.language_counts.pairs
        counts = if options['sort_numerically']
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
