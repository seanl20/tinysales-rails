# frozen_string_literal: true

module Contents
  module Commands
    class Update < Command
      def call(id:, params:)
        content = Repositories::ContentRepo.new.get(id:)

        content.file.attach(params[:file])

        Success(content:)
      end
    end
  end
end
