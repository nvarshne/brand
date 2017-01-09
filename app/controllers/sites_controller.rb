class SitesController < ApplicationController
  before_action :admin_user, only: :destroy

  # POST /sites/
  def create
  end

  # DELETE /sites/:id/
  def destroy
    @site.destroy
    flash[:success] = "Site Deleted"
    redirect_to request.referrer || root_url
  end

  def show
    @site = Site.find(params[:id])
    @proposals = @site.proposals.paginate(page: params[:page], per_page: 15)
  end

  def index
    @sites = Site.where(activated: true).paginate(page: params[:page], per_page: 15)
  end
end
