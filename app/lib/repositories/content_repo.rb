module Repositories
  class ContentRepo
    def create(attrs:)
      Content.create!(attrs)
    end
  end
end
