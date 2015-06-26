module Manage
  class PresentationsController < ApplicationController
    before_action :authenticate_user!

    def create
      presentation = current_user.presentations.create(presentation_params)
      Ppt2pdfJob.perform_later(presentation)
      redirect_to presentation_path(current_user.username, presentation)
    end

    private

      def presentation_params
        params.require(:presentation).permit(:original_file)
      end
  end
end
