class Admin::InvoicesController < ApplicationController
  def index
    @articles = Article.all
    @invoice = Admin::Invoice.new
    @invoices = Admin::Invoice.all.order(created_at: :desc).page(params[:page])

    if params[:from_request]
      product_request = Admin::Request.find(params[:from_request])
      @invoice.invoice_positions_attributes = product_request.request_positions.map do |request_position|
        {article_id: request_position.id, quantity: request_position.quantity}
      end
    end
  end

  def new
  end

  def create
    @invoice = Admin::Invoice.new(invoice_params)
    @invoices = Admin::Invoice.all.order(created_at: :desc).page(params[:page])

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
      params.require(:admin_invoice).permit(:request_id, invoice_positions_attributes: [:article_id, :quantity, :price, :_destroy])
    end
end
