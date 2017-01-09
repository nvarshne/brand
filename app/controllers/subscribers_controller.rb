class SubscribersController < ApplicationController

  def create
    @subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
      flash[:info] = "You've subscribed. Stay tuned to hear more about us!"
      redirect_to root_url
    end
  end

  def destroy
    Subscriber.find(params[:id]).destroy
    flash[:success] = "You have been unsubscribed. Good day!"
    redirect_to root_url
  end

  private
  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
