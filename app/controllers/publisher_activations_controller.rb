class PublisherActivationsController < ApplicationController

  # Linked from mail
  # GET /publisher_activations/:id/?name=:name
  def edit
    publisher = Publisher.find_by(name: params[:name])
    if publisher && !publisher.activated? && publisher.authenticated?(:activation, params[:id])
      publisher.activate
      flash[:success] = "Publisher Activated!"
      redirect_to root_url #redirect to publishers index if admin?
    else
      flash[:danger] = "Invalid Publisher Activation"
      redirect_to root_url
    end
  end
end
