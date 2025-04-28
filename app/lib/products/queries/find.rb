# frozen_string_literal: true

module Products
  module Queries
    class Find < Query
      def call(id:)
        product = Repositories::ProductRepo.new.get(id:)

        return product, product.contents.first
      end
    end
  end
end
