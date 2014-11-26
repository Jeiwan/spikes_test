class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  check_authorization
  skip_authorization_check if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render json: :nothing, status: 401 }
      format.js { render json: :nothing, status: 401 }
    end
  end
end
