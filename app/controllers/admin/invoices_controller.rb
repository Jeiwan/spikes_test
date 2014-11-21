class Admin::InvoicesController < ApplicationController
  def index
    @articles = Article.all
    @invoice = Admin::Invoice.new
    @invoices = Admin::Invoice.all.order(created_at: :desc).page(params[:page])
  end

  def new
  end

  def create
    @invoices = Admin::Invoice.all
    @invoice = Admin::Invoice.new(invoice_params)

    if @invoice.save
      flash[:success] = "Накладная приходована"
      redirect_to admin_invoices_path
    else
      flash.now[:danger] = "Ошибка в приходовании накладной"
      render :index
    end
  end

  private

    def invoice_params
      params.require(:admin_invoice).permit(invoice_positions_attributes: [:article_id, :quantity, :price, :_destroy])
    end
end
