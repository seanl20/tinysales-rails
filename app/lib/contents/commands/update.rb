# frozen_string_literal: true

module Contents
  module Commands
    class Update < Command
      def call(id:)
        content = Repositories::ContentRepo.new.get(id:)

        Success(content:)
      end
    end
  end
end
