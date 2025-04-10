class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    @product = current_user.products.build
  end

  def create
    result = Products::Commands::Create.new.call(params: product_params, user: current_user)

    case result
    in Success(product:)
      redirect_to product_path(product)
    in Failure(:invalid)
      render :new
    end
  end

  def show
    @product = Products::Queries::Find.new.call(id: params[:id])
  end

  private

  def product_params
    params.require(:product).permit(:name, :price)
  end
end
