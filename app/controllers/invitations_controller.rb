class InvitationsController < ApplicationController
  before_action :logged_in_user
  before_action :lead_user

  def new
    @invitation = current_user.publisher.invitations.build
  end

  def create
    @invitation = current_user.publisher.invitations.build(invitation_params)
    if @invitation.save
      @invitation.send_invite_email
      flash[:success] = "Invitation Created"
      redirect_to root_url
    else
      render new_invitation_path
    end
  end

  private

    def invitation_params
      params.require(:invitation).permit(:email)
    end
end
