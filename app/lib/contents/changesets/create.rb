module Contents
  module Changesets
    class Create
      def self.map(tuple)
        tuple.select { |attr| Content.attribute_names.include?(attr.to_s) }
      end
    end
  end
end
