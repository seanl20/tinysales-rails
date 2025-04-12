module Products
  class PublishController < ApplicationController
    before_action :authenticate_user!

    def update
      @product = Products::Commands::PublishProduct.new.call(id: params[:id])

      flash[:success] = "Product successfully published"
      redirect_to edit_product_path(@product)
    end
  end
end
