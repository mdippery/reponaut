module Reponaut
  module Application
    class Presenter
      def format(repo)
        line = repo.name
        line = "#{line} -> #{repo.upstream}" if repo.fork?
        line
      end
    end

    class SimplePresenter < Presenter; end

    class LanguagePresenter < Presenter
      def format(repo)
        line = super
        line += " [#{repo.language}]"
      end
    end

    class LongPresenter < Presenter
      attr_reader :count

      def initialize
        super
        @count = 0
      end

      def format(repo)
        line = super
        line = "\n#{line}" unless @count == 0
        line = "#{line}\n    #{repo.description}"
        @count += 1
        line
      end
    end
  end
end
