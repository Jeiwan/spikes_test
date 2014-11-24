class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:add_to_cart, :remove_from_cart]
  respond_to :js, only: [:add_to_cart, :remove_from_cart]

  authorize_resource

  def index
    @products = Product.page(params[:page])
  end

  def add_to_cart
    @product = Product.find(params[:product_id])
    if @product
      session[:cart] ||= []
      session[:cart] << {name: @product.name, id: @product.id, article: @product.article_id, stack: @product.product_stack_id, price: @product.price, quantity: 1}
    end
  end

  def remove_from_cart
    puts params
    if params["product_id"]
      session[:cart].reject! { |product| product["id"] == params["product_id"].to_i  }
    end
  end
end
