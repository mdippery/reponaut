module Reponaut
  class StatisticsCalculator
    attr_reader :repos

    def initialize(repos)
      @repos = repos
    end

    def language_counts
      langs = Hash.new { |hash, key| hash[key] = 0 }
      @repos.map { |r| langs[r.language] += 1 }
      langs
    end
  end
end
