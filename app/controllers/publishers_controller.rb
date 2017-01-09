class PublishersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  #before_action :team_user, only: :show
  before_action :lead_user, only: [:edit, :update, :destroy]
  #before_action :admin_user, only: :index

  # Platform Registration
  # GET /publishers/new/
  def new
    @publisher = Publisher.new
    @publisher.users.build
    @publisher.sites.build
    @buyorg = BuyOrg.new
    @buyorg.users.build
    @buyorg.brands.build
  end

  # POST /publishers/
  def create
    @publisher = Publisher.new(publisher_params)
    @publisher.users.map{ |u| u[:lead] = true }
    if @publisher.save
      @publisher.send_activation_email
      flash[:info] = "BrandVerge will review your request to join the platform. In the meantime, please check your email to hear from us."
      redirect_to root_url
    else
      render 'new'
    end
  end

  # GET /publishers/
  def index
    @publishers = Publisher.where(activated: true).paginate(page: params[:page])
  end

  # GET /publishers/:id
  def show
    @publisher = Publisher.find(params[:id])
    @proposals = @publisher.proposals.paginate(page: params[:page], per_page: 15)
    @users = @publisher.users
  end

  # GET /publishers/:id/edit/
  def edit
  end

  # PATCH /publishers/:id/
  def update
    if @publisher.update_attributes(publisher_only_params)
      flash[:success] = "Publisher updated"
      redirect to @publisher
    else
      render 'edit'
    end
  end

  # DELETE /publishers/:id/
  def destroy
  end

  private
    def publisher_params
      params.require(:publisher).permit(:name,
                                        users_attributes: [:name, :email, :password, :password_confirmation],
                                        sites_attributes: [:name, :url])
    end

    def publisher_only_params
      params.require(:publisher).permit(:name)
    end

    def team_user
      @publisher = Publisher.find(params[:id])
      if !admin || !current_user.publisher == @publisher
        redirect_to(root_url)
      end
    end

    def lead_user
      @publisher = Publisher.find(params[:id])
      if !current_user.lead? && current_user.publisher == @publisher
        redirect_to(root_url)
      end
    end
end
