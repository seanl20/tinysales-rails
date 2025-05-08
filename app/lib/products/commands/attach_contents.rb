# frozen_string_literal: true

module Products
  module Commands
    class AttachContents < Command
      def call(content_ids:, product_id:, content_params:)
        content_params.map do |content_param|
          update_content(content_param:, product_id:)
        end
      end

      def update_content(content_param:, product_id:)
        attrs = {
          name: content_param[:name],
          description: content_param[:description],
          product_id:
        }

        Repositories::ContentRepo.new.update(id: content_param[:id], attrs:)
      end
    end
  end
end
