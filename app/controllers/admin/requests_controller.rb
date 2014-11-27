class Admin::RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_settings, only: [:index]
  before_action :load_request, only: [:edit, :update, :confirm]
  before_action :load_articles, only: [:new, :edit]

  authorize_resource

  def index
    @requests = Admin::Request.all.order(created_at: :desc).page(params[:page])
  end

  def new
    @request = Admin::Request.new
    @request.request_positions.new
  end

  def create
    @request = Admin::Request.new(request_params)

    if @request.save
      flash[:success] = "Заявка создана"
      redirect_to admin_requests_path
    else
      flash.now[:danger] = "Ошибка в создании запроса"
      render :new
    end
  end

  def edit
  end

  def update
    if @request.update(request_params)
      flash[:success] = 'Заявка отредактирована'
      redirect_to admin_requests_path
    else
      flash.now[:danger] = 'Ошибка при редактировании заявки'
      render :edit
    end
  end

  def merge
    if params[:merge_requests]
      Admin::Request.merge(params[:merge_requests])

      flash[:success] = "Запросы объединены"
      redirect_to admin_requests_path
    end
  end

  def confirm
    @request.pending!
    flash[:success] = 'Заявка подтверждена'
    redirect_to admin_requests_path
  end

  private

    def request_params
      params.require(:admin_request).permit(request_positions_attributes: [:id, :article_id, :quantity, :_destroy])
    end

    def load_settings
      @settings = {}
      Admin::Setting.find_each do |settings|
        @settings[settings.name.to_sym] = settings.value
      end
    end

    def load_request
      @request = Admin::Request.find(params[:request_id] || params[:id])
    end

    def load_articles
      @articles = Article.all
    end
end
