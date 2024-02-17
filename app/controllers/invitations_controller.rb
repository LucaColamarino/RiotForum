class InvitationsController < ApplicationController

    def update
      invitation = Invitation.find(params[:id])
      invitation.update(confirmed: true)
      redirect_to invitations_path, notice: 'Invitation was successfully accepted.'
    end

    def destroy
        @invitation = Invitation.find(params[:id])
        @invitation.destroy
        redirect_to invitations_path, notice: 'Invitation was successfully destroyed.'
      end

end
