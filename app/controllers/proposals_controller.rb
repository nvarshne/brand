class ProposalsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :show, :destroy]
  before_action :seller_user,    only: [:new, :create, :show]
  before_action :correct_user,   only: :destroy
  before_action :admin_user,          only: :index

  # GET /proposals/new/
  def new
    @proposal = current_user.proposals.build
  end

  # GET /get_indicator_options
  def get_indicator_options
    return if params[:objective] == nil
    val = params[:objective]
    options = Choices['objectives'].select{ |o| o['name'] == val }[0]['kpis']
    render json: options
  end

  # POST /proposals/
  def create
    @proposal = current_user.proposals.build(proposal_params)
    @proposal.active = true
    if @proposal.save
      flash[:success] = "Proposal created!"
      redirect_to root_url
    else
      render new_proposal_path
    end
  end

  # GET /proposals/:id/
  def show
    @proposal = Proposal.find(params[:id])
  end

  # TODO this is a rough sketch
  def download
    proposal = Proposal.find(params[:id])
    return unless proposal.has_attribute?(:support_doc)
    data = open("https://s3.amazonaws.com/#{proposal.support_doc}")
    send_data data.read, filename: "support-#{proposal.support_doc.split('/').last}"
  end

  # GET /proposals/:id/edit
  # TODO
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
      params.require(:proposal).permit(:site_id,
                                       :summary,
                                       :description,
                                       :first_to_market,
                                       :sponsored,
                                       :est_reach,
                                       :min_price,
                                       :max_price,
                                       :lead_time,
                                       :flight_length,
                                       :start_date,
                                       :support_doc,
                                       :integration,
                                       :categories,
                                       :p_objective,
                                       :p_indicators,
                                       :s_objective,
                                       :s_indicators)
    end

    # This person is the proposal owner
    def correct_user
      @proposal = current_user.proposals.find_by(id: params[:id])
      redirect_to root_url if @proposal.nil?
    end
end
