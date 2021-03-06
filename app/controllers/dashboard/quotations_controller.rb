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
    @company_profiles = current_user.company_profiles
    render
  end

  def create
    @clients = current_user.clients
    @company_profiles = current_user.company_profiles
    @quotation = @user.quotations.new quotation_params
    if @quotation.save
      redirect_to dashboard_quotations_path, notice: 'Quotation created!'
    else
      render 'new'
    end
  end

  def edit
    @clients = current_user.clients
    @company_profiles = current_user.company_profiles
    if @quotation
      render
    else
      redirect_to dashboard_quotations_path, notice: 'Quotation not found!'
    end
  end

  def update
    @clients = current_user.clients
    @company_profiles = current_user.company_profiles
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
      params.require(:quotation).permit(:user_id, :sender_id, :client_id, :ref_number, :valid_until, :status, :sub_total, :tax_rate, :tax, :total, :note, items_attributes: [:id, :itemable_type, :itemable_id, :description, :quantity, :price, :total_price, :_destroy])
    end
end
