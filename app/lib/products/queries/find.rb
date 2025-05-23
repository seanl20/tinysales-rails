# frozen_string_literal: true

module Products
  module Queries
    class Find < Query
      def call(id:)
        Repositories::ProductRepo.new.get(id:)
      end
    end
  end
end
