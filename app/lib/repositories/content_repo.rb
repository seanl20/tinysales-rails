module Repositories
  class ContentRepo
    def create(attrs:)
      Content.create!(attrs)
    end

    def get(id:)
      Content.find(id)
    end
  end
end
