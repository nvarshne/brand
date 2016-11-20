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

  # TODO only sites from activated publishers
  def index
    @sites = Site.all.paginate(page: params[:page], per_page: 15)
  end
end
