module Products
  class AttachContentsController < ApplicationController
    protect_from_forgery with: :null_session
    # before_action :authenticate_user!

    def create
      @product = Commands::AttachContents.new.call(content_ids: content_ids, product_id: params[:product_id], content_params:)

      flash[:success] = "Files Successfully Uploaded."
      redirect_to edit_product_path(@product)
    end

    def content_params
      params.permit(contents: [ :id, :name, :description ])
    end

    def content_ids
      content_params[:contents].map do |content_param|
        content_param[:id]
      end
    end
  end
end
