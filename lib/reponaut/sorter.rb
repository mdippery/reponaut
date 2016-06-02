module Reponaut
  module Application
    class Sorter
      attr_reader :name, :count

      def initialize(pair)
        @name, @count = pair
      end
    end

    class LexicographicalSorter < Sorter
      def <=>(o)
        return nil unless o.kind_of? self.class
        name <=> o.name
      end
    end

    class NumericalSorter < Sorter
      def <=>(o)
        return nil unless o.kind_of? self.class
        if count == o.count
          name <=> o.name
        else
          o.count <=> count
        end
      end
    end
  end
end
