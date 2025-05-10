module Repositories
  class ContentRepo
    def create(attrs:)
      Content.create!(attrs)
    end

    def get(id:)
      Content.find(id)
    end

    def get_by_ids(ids:)
      Content.where(id: ids)
    end

    def update(id:, attrs:)
      Content
        .find(id)
        .update!(attrs)
    end

    def delete(id:)
      Content.find(id).destroy
    end
  end
end
