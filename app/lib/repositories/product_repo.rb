module Repositories
  class ProductRepo
    def create(attrs:)
      Product.create!(attrs)
    end

    def get(id:)
      Product.friendly.find(id)
    end

    def update(id:, attrs:)
      Product
        .friendly
        .find(id)
        .update!(attrs)
    end
  end
end
