class Dashboard::ClientsController < DashboardController
  before_action :authenticate_user!
  before_action :set_user, only: [:index, :new, :create, :edit, :update, :destroy, :show]
  before_action :find_client, only: [:edit, :update, :destroy, :show]

  def index
    @clients = @user.clients
  end

  def new
    @client ||= CompanyProfile.new
    render
  end

  def create
    @client = @user.clients.new client_params
    if @client.save
      redirect_to dashboard_clients_path, notice: 'Client created!'
    else
      render 'new'
    end
  end

  def show() end

  def edit
    if @client
      render
    else
      redirect_to dashboard_clients_path, notice: 'Client not found!'
    end
  end

  def update
    if @client.update client_params
      redirect_to dashboard_clients_path, notice: 'Client updated!'
    else
      render 'edit'
    end
  end

  def destroy
    if @client.destroy
      redirect_to dashboard_clients_path, notice: 'Client deleted!'
    else
      render 'index'
    end
  end

  private

    def set_user
      @user = current_user
    end

    def find_client
      @client = @user.clients.find params[:id]
      rescue ActiveRecord::RecordNotFound
        redirect_to(dashboard_clients_url, :notice => 'Record not found')
    end

    def client_params
      params.require(:client).permit(:user_id, :contact_person_name, :contact_person_email, :contact_person_phone, :company_name, :company_phone_number, :company_address, :company_postcode, :company_city, :company_state, :company_country, :company_email)
    end
end
