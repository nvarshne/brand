class BuyOrgsController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :team_user, only: :show
  before_action :lead_user, only: [:edit, :update, :destroy]
  before_action :admin_user, only: :index

  # Please see publishers_controller to witness the creation page
  def new
  end

  # POST /buyorgs/
  def create
    @buyorg = BuyOrg.new(buyorg_params)
    @buyorg.users.map{ |u| u[:lead] = true }
    if @buyorg.save
      @buyorg.send_activation_email
      flash[:info] = "BrandVerge will review your request to join the platform. In the meantime, please check your email to listen for us."
      redirect_to root_url
    else
      render 'new'
    end
  end

  # GET /buyorgs/
  def index
    @buyorgs = BuyOrg.where(activated: true).paginate(page: params[:page])
  end

  # GET /buyorgs/:id
  def show
    @buyorg = BuyOrg.find(params[:id])
    @brands = @buyorg.brands
    @users = @buyorg.users
  end

  # GET /buyorgs/:id/edit/
  def edit
  end

  # PATCH /buyorgs/:id/
  def update
    if @buyorg.update_attributes(buyorg_only_params)
      flash[:success] = "Organization updated"
      redirect to @buyorg
    else
      render 'edit'
    end
  end

  # DELETE /buyorgs/:id/
  def destroy
  end

  private
    def buyorg_params
      params.require(:buyorg).permit(:name,
                                        users_attributes: [:name, :email, :password, :password_confirmation],
                                        brands_attributes: [:name])
    end

    def buyorg_only_params
      params.require(:buyorg).permit(:name)
    end

    def team_user
      @buyorg = BuyOrg.find(params[:id])
      if !admin || !current_user.buyorg == @buyorg
        redirect_to(root_url)
      end
    end

    def lead_user
      @buyorg = BuyOrg.find(params[:id])
      if !current_user.lead? && current_user.buyorg == @buyorg
        redirect_to(root_url)
      end
    end
end
