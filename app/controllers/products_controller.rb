class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = current_user.products
  end

  def new
    @product = current_user.products.build
  end

  def create
    result = Products::Commands::Create.new.call(params: product_params, user: current_user)

    case result
    in Success(product:)
      redirect_to edit_product_path(product)
    in Failure(:invalid)
      render :new
    end
  end

  def show
    @product = Products::Queries::Find.new.call(id: params[:id])
  end

  def edit
    @product = Products::Queries::Find.new.call(id: params[:id])
  end

  def update
    result = Products::Commands::Update.new.call(id: params[:id], params: product_params)

    case result
    in Success(product:)
      flash[:success] = "Product successfully updated."
      redirect_to edit_product_path(product)
    in Failure(:invalid)
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :slug, :description, :thumbnail, :cover, contents: [])
  end
end
