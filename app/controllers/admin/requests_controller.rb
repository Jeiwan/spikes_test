class Admin::RequestsController < ApplicationController
  before_action :load_settings, only: [:index]

  def index
    @articles = Article.all
    @request = Admin::Request.new
    @requests = Admin::Request.all.order(created_at: :desc).page(params[:page])
  end

  def create
    @requests = Admin::Request.all
    @request = Admin::Request.new(request_params)

    if @request.save
      flash[:success] = "Заявка создана"
      redirect_to admin_requests_path
    else
      flash.now[:danger] = "Ошибка в создании запроса"
      render :index
    end
  end

  private

    def request_params
      params.require(:admin_request).permit(request_positions_attributes: [:article_id, :quantity, :executed, :_destroy])
    end

    def load_settings
      @settings = {}
      Admin::Setting.find_each do |settings|
        @settings[settings.name.to_sym] = settings.value
      end
    end
end
