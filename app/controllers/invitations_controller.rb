class InvitationsController < ApplicationController

    def update
      invitation = Invitation.find(params[:id])
      invitation.update(confirmed: true)
      redirect_to invitations_path, notice: User.find(params[:id]).pluck('username')+'è ora tuo amico.'
    end

    def destroy
        @invitation = Invitation.find(params[:id])
        @invitation.destroy
        redirect_to invitations_path
      end

end
