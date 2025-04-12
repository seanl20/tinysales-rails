# frozen_string_literal: true

module Products
  module Commands
    class UnpublishProduct < Command
      def call(id:)
        Repositories::ProductRepo.new.update_published(id:, published: false)

        Repositories::ProductRepo.new.get(id:)
      end
    end
  end
end
