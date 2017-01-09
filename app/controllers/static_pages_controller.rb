class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page])
    else
      @subscriber = Subscriber.new
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
