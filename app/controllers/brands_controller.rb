class BrandsController < ApplicationController
  before_action :admin_user, only: :destroy

  # POST /brands/
  def create
  end

  # DELETE /brands/:id/
  def destroy
    @brand.destroy
    flash[:success] = "Brand Deleted"
    redirect_to request.referrer || root_url
  end

  def show
    @brand = Brand.find(params[:id])
    @proposals = @brand.proposals.paginate(page: params[:page], per_page: 15)
  end

  def index
    @brands = Brand.where(activated: true).paginate(page: params[:page], per_page: 15)
  end
end
