class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    #TODO fix
    def seller_user
      redirect_to root_url unless current_user.seller?
    end

    def lead_user
      redirect_to(root_url) unless current_user.lead?
    end

    #TODO fix
    def team_user
      redirect_to(root_url) unless current_user.publisher == Proposal.find(params[:id]).user.publisher
    end
end
