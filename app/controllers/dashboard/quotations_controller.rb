class Dashboard::QuotationsController < DashboardController
  before_action :authenticate_user!
  before_action :set_user, only: [:index, :new, :create, :edit, :update, :destroy, :show]
  before_action :find_quotation, only: [:edit, :update, :destroy, :show]

  def index
    @quotations = @user.quotations
  end

  def new
    @quotation ||= Quotation.new
    @clients = current_user.clients
    render
  end

  def create
    @clients = current_user.clients
    @quotation = @user.quotations.new quotation_params
    if @quotation.save
      redirect_to dashboard_quotations_path, notice: 'Quotation created!'
    else
      render 'new'
    end
  end

  def edit
    @clients = current_user.clients
    if @quotation
      render
    else
      redirect_to dashboard_quotations_path, notice: 'Quotation not found!'
    end
  end

  def update
    @clients = current_user.clients
    if @quotation.update quotation_params
      redirect_to dashboard_quotations_path, notice: 'Quotation updated!'
    else
      render 'edit'
    end
  end

  def show() end

  def destroy
    if @quotation.destroy
      redirect_to dashboard_quotations_path, notice: 'Quotation deleted!'
    else
      render 'index'
    end
  end

  private

    def set_user
      @user = current_user
    end

    def find_quotation
      @quotation = @user.quotations.find params[:id]
      rescue ActiveRecord::RecordNotFound
        redirect_to(dashboard_quotations_url, :notice => 'Record not found')
    end

    def quotation_params
      params.require(:quotation).permit(:user_id, :client_id, :ref_number, :valid_until, :status, :sub_total, :tax_rate, :tax, :total, :note)
    end
end
