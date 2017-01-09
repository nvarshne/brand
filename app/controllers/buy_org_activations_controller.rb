class BuyOrgActivationsController < ApplicationController

  # Linked from mail
  # GET /buyorg_activations/:id/?name=:name
  def edit
    buyorg = BuyOrg.find_by(name: params[:name])
    if buyorg && !buyorg.activated? && buyorg.authenticated?(:activation, params[:id])
      buyorg.activate
      flash[:success] = "Organization Activated!"
      redirect_to root_url #redirect to buyorgs index if admin?
    else
      flash[:danger] = "Invalid Activation"
      redirect_to root_url
    end
  end
end
