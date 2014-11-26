class OrdersController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def index_admin
    @orders = Order.page(params[:page])
    render 'admin/orders/index'
  end

  def create
    unless session[:cart].blank?
      order = current_user.orders.create

      session[:cart].each do |product|
        order.order_positions.create(article_id: product['article'], quantity: product['quantity'], price: product['price'])
        @product_stack = Product.find(product['id']).product_stack
        @product_stack.decrement(:quantity, product['quantity'].to_i).save!
      end

      flash[:success] = "Заказ оформлен"
    end
    redirect_to root_path
  end
end
