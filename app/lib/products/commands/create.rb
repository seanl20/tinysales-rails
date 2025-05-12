# frozen_string_literal: true

module Products
  module Commands
    class Create < Command
      def call(params:, user:)
        params[:price] = 0 if params[:price].is_a?(String)

        attrs = Products::Changesets::Create.map(params).merge({ user: })

        product = yield create_product(attrs:)

        product.thumbnail.attach(params[:thumbnail])

        Success(product:)
      end

      def create_product(attrs:)
        Success(Repositories::ProductRepo.new.create(attrs:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
