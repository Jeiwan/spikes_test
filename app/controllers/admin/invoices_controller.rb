class Admin::InvoicesController < ApplicationController

  authorize_resource

  def index
    @invoices = Admin::Invoice.all.order(created_at: :desc).page(params[:page])
  end

  def new
    @articles = Article.all

    if params[:request_id]
      @request = Admin::Request.find(params[:request_id])
      @invoice = @request.build_invoice_and_add_positions
    else
      @invoice = Admin::Invoice.new
      @invoice.invoice_positions.new
    end
  end

  def create
    if params[:request_id]
      @request = Admin::Request.find(params[:request_id])
      @invoice = @request.build_invoice(invoice_params)
    else
      @invoice = Admin::Invoice.new(invoice_params)
    end

    if @invoice.save
      flash[:success] = "Накладная приходована"
      redirect_to admin_invoices_path
    else
      flash.now[:danger] = "Ошибка в приходовании накладной"
      render :new
    end
  end

  private

    def invoice_params
      params.require(:admin_invoice).permit(:request_id, invoice_positions_attributes: [:article_id, :quantity, :price, :_destroy])
    end
end
