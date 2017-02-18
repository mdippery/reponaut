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
        if filtered_repos.empty?
          msg = "#{username} has no repositories"
          msg += " written in #{language}" if language
          quit 4, msg
        end

        formatter = formatter_class(options).new
        filtered_repos.sort.each do |r|
          puts formatter.format(r)
        end
      end

      private

      def formatter_class(options)
        options['show_description'] ? LongPresenter : SimplePresenter
      end
    end
  end
end
