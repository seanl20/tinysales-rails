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

        product = Repositories::ProductRepo.new.get(id: params[:slug])
        attach_images(product:, params:)

        Success(product:)
      end

      def update_products(id:, attrs:)
        Success(Repositories::ProductRepo.new.update(id:, attrs:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end

      def attach_images(product:, params:)
        product.thumbnail.attach(params[:thumbnail]) if params[:thumbnail]
        product.cover.attach(params[:cover]) if params[:cover]
      end
    end
  end
end
