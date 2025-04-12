# frozen_string_literal: true

module Products
  module Commands
    class PublishProduct < Command
      def call(id:)
        Repositories::ProductRepo.new.update_published(id:, published: true)

        Repositories::ProductRepo.new.get(id:)
      end
    end
  end
end
