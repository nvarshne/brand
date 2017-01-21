class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  around_action :set_user_time_zone, if: :logged_in?

  private

    def set_user_time_zone(&block)
      Time.use_zone(current_user.time_zone, &block)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def seller_user
      if !current_user.seller? || !current_user.admin?
        redirect_to root_url
      end
    end

    def buyer_user
      if !current_user.buyer? || !current_user.admin?
        redirect_to root_url
      end
    end
end
