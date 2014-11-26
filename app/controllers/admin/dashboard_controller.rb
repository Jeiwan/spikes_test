class Admin::DashboardController < ApplicationController
  def show
    @invoices = Admin::Invoice.limit(10)
    @requests = Admin::Request.limit(10)
    @products = Product.limit(10)
    @orders = Order.limit(10)
  end
end
