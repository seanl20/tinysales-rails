# frozen_string_literal: true

module Contents
  module Commands
    class Delete < Command
      def call(id:)
        Repositories::ContentRepo.new.delete(id:)
      end
    end
  end
end
