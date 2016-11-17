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
end
