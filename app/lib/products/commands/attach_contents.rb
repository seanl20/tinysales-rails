# frozen_string_literal: true

module Products
  module Commands
    class AttachContents < Command
      def call(content_ids:, product_id:, content_params:)
        content_params[:contents].each do |content_param|
          update_content(content_param:, product_id:)
        end

        Repositories::ProductRepo.new.get(id: product_id)
      end

      def update_content(content_param:, product_id:)
        attrs = {
          name: content_param[:name],
          description: content_param[:description].blank? ? nil : content_param[:description],
          product_id:
        }

        Repositories::ContentRepo.new.update(id: content_param[:id], attrs:)
      end
    end
  end
end
