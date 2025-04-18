module Products
  class ContentsController < ApplicationController
    before_action :authenticate_user!

    def index
      @product = Products::Queries::Find.new.call(id: params[:product_id])
    end
  end
end
