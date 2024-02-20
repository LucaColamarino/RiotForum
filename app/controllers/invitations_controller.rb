class InvitationsController < ApplicationController

    def update
      invitation = Invitation.find(params[:id])
      invitation.update(confirmed: true)
      redirect_to request.fullpath
    end

    def destroy
        @invitation = Invitation.find(params[:id])
        @invitation.destroy
        redirect_to request.fullpath
      end

end
