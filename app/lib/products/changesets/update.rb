module Products
  module Changesets
    class Update
      def self.map(tuple)
        tuple.select { |attr| Product.attribute_names.include?(attr.to_s) }
      end
    end
  end
end
