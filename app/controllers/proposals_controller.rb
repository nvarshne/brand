class ProposalsController < ApplicationController
  before_action :logged_in_user, only: [:show, :create, :destroy]
  before_action :correct_user,   only: :destroy

  # GET /proposals/new/
  def new
  end

  # GET /proposals/:id/
  def show
    @proposal = Proposal.find(params[:id])
  end

  # POST /proposals/
  def create
    @proposal = current_user.proposals.build(proposal_params)
    if @proposal.save
      flash[:success] = "Proposal created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  # DELETE /proposals/:id/
  def destroy
    @proposal.destroy
    flash[:success] = "Proposal deleted"
    redirect_to request.referrer || root_url
  end

  private

    def proposal_params
      params.require(:proposal).permit(:summary)
    end

    def correct_user
      @proposal = current_user.proposals.find_by(id: params[:id])
      redirect_to root_url if @proposal.nil?
    end
end
