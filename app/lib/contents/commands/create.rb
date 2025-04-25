# frozen_string_literal: true

module Contents
  module Commands
    class Create < Command
      def call(params:)
        attrs = Contents::Changesets::Create.map(params)

        content = yield create_content(attrs:)

        Success(content:)
      end

      def create_content(attrs:)
        Success(Repositories::ContentRepo.new.create(attrs:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
