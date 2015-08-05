module Reponaut
  class StatisticsCalculator
    attr_reader :repos

    def initialize(repos)
      @repos = repos
    end

    def language_counts
      langs = Hash.new { |hash, key| hash[key] = 0 }
      repos.group_by { |r| r.language }.map { |e| langs[e[0]] = e[1].count }
      langs
    end
  end
end
