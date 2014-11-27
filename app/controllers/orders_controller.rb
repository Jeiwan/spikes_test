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
      order.fill_from_cart(session[:cart])
      session[:cart] = []
      flash[:success] = "Заказ оформлен"
    end
    redirect_to root_path
  end
end
