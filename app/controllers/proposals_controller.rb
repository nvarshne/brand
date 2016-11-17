class ProposalsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :show, :destroy]
  before_action :seller_user,    only: [:new, :create, :show]
  before_action :correct_user,   only: :destroy
  before_action :admin_user,          only: :index

  # GET /proposals/new/
  def new
    @proposal = current_user.proposals.build
  end

  # POST /proposals/
  def create
    @proposal = current_user.proposals.build(proposal_params)
    if @proposal.save
      flash[:success] = "Proposal created!"
      redirect_to root_url
    else
      @feed_items = []
      render new_proposal_path
    end
  end

  # GET /proposals/:id/
  def show
    @proposal = Proposal.find(params[:id])
  end

  # GET /proposals/:id/edit
  def edit
  end

  # PATCH /proposals/:id/
  def update
  end

  # DELETE /proposals/:id/
  def destroy
    @proposal.destroy
    flash[:success] = "Proposal deleted"
    redirect_to request.referrer || root_url
  end

  private

    def proposal_params
      params.require(:proposal).permit(:summary, :site_id)
    end

    # This person is the proposal owner
    def correct_user
      @proposal = current_user.proposals.find_by(id: params[:id])
      redirect_to root_url if @proposal.nil?
    end
end
