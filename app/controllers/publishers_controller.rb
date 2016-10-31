class PublishersController < ApplicationController
  before_action :lead_user, only: [:edit, :update, :destroy]
  before_action :team_user, only: [:show]
  before_action :admin_user, only: [:index, :show, :destroy]

  def new
    @publisher = Publisher.new
    @publisher.users.build
  end

  def create
    @publisher = Publisher.new(publisher_params)
    @publisher.users.map{ |u| u[:lead] = true }
    if @publisher.save
      @publisher.send_activation_email
      flash[:info] = "Colab will review your request to join the platform. In the meantime, please check your email to hear from us."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
  end

  def show
  end

  # GET /publishers/:id/edit/
  def edit
    @publisher = Publisher.find(params[:id])
  end

  # PATCH /publishers/:id/edit
  def update
    @publisher = Publisher.find(params[:id])
    if @publisher.update_attributes(publisher_only_params)
      flash[:success] = "Publisher updated"
      redirect to @publisher
    else
      render 'edit'
    end
  end

  private
    def publisher_params
      params.require(:publisher).permit(:name,
                                        users_attributes: [:name, :email, :password, :password_confirmation])
    end

    def publisher_only_params
      params.require(:publisher).permit(:name)
    end

    def lead_user
      redirect_to(root_url) unless current_user.lead?
    end
end
