module Reponaut
  module Application
    class List < Command
      def initialize(prog)
        prog.command(:list) do |c|
          c.alias :ls
          c.syntax 'list [options] <username> [language]'
          c.description "List a user's repos"
          c.option 'ignore_forks', '-f', 'Ignore forks'
          c.option 'show_description', '-d', 'Show repo description'

          c.action do |args, options|
            process(options, args)
          end
        end
      end

      def process(options, args)
        super

        language = args[1]

        filtered_repos = repos
        filtered_repos = filtered_repos.select { |r| r.language.downcase == language.downcase } if language
        quit 4, "#{username} has no repositories written in #{language}" if filtered_repos.empty?

        filtered_repos.sort.each do |r|
          line = r.name
          line = "#{line} -> #{r.upstream}" if r.fork?
          line = "#{line}: #{r.description}" if options['show_description']
          puts line
        end
      end
    end
  end
end
