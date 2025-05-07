# frozen_string_literal: true

module Products
  module Commands
    class Create < Command
      def call(content_ids:, product_id:)
        product = Repositories::ProductRepo.new.get(id: product_id)
        contents = Repositories::ContentRepo.new.get_all(ids: content_ids)
      end
    end
  end
end
