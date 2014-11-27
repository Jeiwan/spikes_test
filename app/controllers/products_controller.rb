class ProductsController < ApplicationController
  before_action :authenticate_user!, except: :index
  respond_to :js, except: [:index, :index_admin]

  authorize_resource

  def index
    @products = Product.page(params[:page])
  end

  def index_admin
    @products = Product.page(params[:page])
    render "admin/products/index"
  end

  def add_to_cart
    @product = Product.find(params[:product_id])
    if @product
      session[:cart] ||= []
      session[:cart] << {name: @product.name, id: @product.id, article: @product.article_id, price: @product.price, quantity: 1}
    end
  end

  def remove_from_cart
    if params[:product_id]
      session[:cart].reject! { |product| product.with_indifferent_access[:id] == params[:product_id].to_i  }
    end
  end

  def set_quantity_threshold
    @product = Product.find(params[:id])
    @product.update!(product_params)
    render "admin/products/set_quantity_threshold"
  end

  private
  
    def product_params
      params.require(:product).permit(:quantity_threshold)
    end
end
