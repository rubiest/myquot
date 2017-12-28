class Account::CompanyProfilesController < DashboardController
  before_action :authenticate_user!
  before_action :require_enterprise
  before_action :set_user, only: [:index, :new, :create, :edit, :update, :destroy, :show]
  before_action :find_company_profile, only: [:edit, :update, :destroy, :show]

  def index
    @company_profiles = @user.company_profiles
  end

  def new
    @company_profile ||= CompanyProfile.new
    render
  end

  def create
    @company_profile = @user.company_profiles.new company_profile_params
    if @company_profile.save
      redirect_to account_company_profiles_path, notice: 'Company profile created!'
    else
      render 'new'
    end
  end

  def show() end

  def edit
    if @company_profile
      render
    else
      redirect_to account_company_profiles_path, notice: 'Company profile not found!'
    end
  end

  def update
    if @company_profile.update company_profile_params
      redirect_to account_company_profiles_path, notice: 'Company profile updated!'
    else
      render 'edit'
    end
  end

  def destroy
    if @company_profile.destroy
      redirect_to account_company_profiles_path, notice: 'Company profile deleted!'
    else
      render 'index'
    end
  end

  private

    def set_user
      @user = current_user
    end

    def find_company_profile
      @company_profile = @user.company_profiles.find params[:id]
      rescue ActiveRecord::RecordNotFound
        redirect_to(account_company_profiles_url, :notice => 'Record not found')
    end

    def company_profile_params
      params.require(:company_profile).permit(:user_id, :company_name, :contact_number, :address, :postcode, :city, :state, :country, :logo, :reg_num)
    end
end
