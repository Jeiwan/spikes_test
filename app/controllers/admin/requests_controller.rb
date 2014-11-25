class Admin::RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_settings, only: [:index]

  authorize_resource

  def index
    @requests = Admin::Request.all.order(created_at: :desc).page(params[:page])
  end

  def new
    @articles = Article.all
    @request = Admin::Request.new
    @request.request_positions.new
  end

  def create
    @requests = Admin::Request.all
    @request = Admin::Request.new(request_params)

    if @request.save
      flash[:success] = "Заявка создана"
      redirect_to admin_requests_path
    else
      flash.now[:danger] = "Ошибка в создании запроса"
      render :new
    end
  end

  def merge
    if params[:merge_requests]
      Admin::Request.merge(params[:merge_requests])

      flash[:success] = "Запросы объединены"
      redirect_to admin_requests_path
    end
  end

  private

    def request_params
      params.require(:admin_request).permit(request_positions_attributes: [:article_id, :quantity, :_destroy])
    end

    def load_settings
      @settings = {}
      Admin::Setting.find_each do |settings|
        @settings[settings.name.to_sym] = settings.value
      end
    end
end
