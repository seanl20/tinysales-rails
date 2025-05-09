# frozen_string_literal: true

module Products
  module Queries
    class FindWithContents < Query
      def call(id:)
        product = Repositories::ProductRepo.new.get(id:)

        return product, product.contents
      end
    end
  end
end
