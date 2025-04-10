module Repositories
  class ProductRepo
    def create(attrs:)
      Product.create!(attrs)
    end

    def get(id:)
      Product.find(id)
    end
  end
end
