module Repositories
  class ProductRepo
    def create(attrs:)
      Product.create!(attrs)
    end

    def get(id:)
      Product.friendly.includes(:contents).find(id)
    end

    def update(id:, attrs:)
      Product
        .friendly
        .find(id)
        .update!(attrs)
    end

    def update_published(id:, published:)
      Product
        .friendly
        .find(id)
        .update(published:)
    end
  end
end
