class UsersController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def cart
    @products_in_cart = session[:cart]
  end
end
