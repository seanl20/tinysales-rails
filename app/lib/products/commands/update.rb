# frozen_string_literal: true

module Products
  module Commands
    class Update < Command
      def call(id:, params:)
        attrs = Products::Changesets::Update.map(params).merge({
          price: params[:price],
          description: params[:description]
        })

        yield update_products(id:, attrs:)

        Success(product: Repositories::ProductRepo.new.get(id: params[:slug]))
      end

      def update_products(id:, attrs:)
        Success(Repositories::ProductRepo.new.update(id:, attrs:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
