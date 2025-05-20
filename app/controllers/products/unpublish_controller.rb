module Products
  class UnpublishController < ApplicationController
    before_action :authenticate_user!

    def update
      @product = Products::Commands::UnpublishProduct.new.call(id: params[:id])

      respond_to do |format|
        format.turbo_stream do
          flash[:success] = "Product successfully unpublished"
          render turbo_stream: [
            (turbo_stream.update "publish-button", partial: "products/publish_button", locals: { product: @product }),
            (turbo_stream.update "flash", partial: "layouts/flash")
          ]
        end
      end
    end
  end
end
