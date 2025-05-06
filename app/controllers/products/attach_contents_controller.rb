module Products
  class AttachContentsController < ApplicationController
    before_action :authenticate_user!

    def create
      @product, @contents = Products::Queries::Find.new.call(id: params[:product_id])
    end
  end
end
