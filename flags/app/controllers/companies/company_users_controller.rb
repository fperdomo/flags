class Companies::CompanyUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company

  def create
    company_user = @company.company_users.new(company_user_params)
    company_user.company = @company
  
    if company_user.save
      redirect_to @company, notice: 'Saved!'
    else
      redirect_to @company, alert: 'Failed saving!'
    end
  end

  private
    def set_company
      @company = current_user.companies.find(params[:company_id])
    end

    def company_user_params
      params.require(:company_user).permit(:email)
    end
end