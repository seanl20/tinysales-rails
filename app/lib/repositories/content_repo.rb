module Repositories
  class ContentRepo
    def create(attrs:)
      Content.create!(attrs)
    end

    def get(id:)
      Content.find(id)
    end

    def get_all(ids:)
      Contents.where(id: ids)
    end
  end
end
