module Manage
  class PresentationsController < ApplicationController
    before_action :authenticate_user!

    def index
      @presentations = current_user.presentations
      render "presentations/index"
    end

    def create
      presentation = current_user.presentations.create(create_presentation_params)
      Ppt2pdfJob.perform_later(presentation)
      redirect_to edit_manage_presentation_path(presentation)
    end

    def edit
      @presentation = current_user.presentations.find(params[:id])
    end

    def update
      presentation = current_user.presentations.find(params[:id])
      presentation.update(update_presentation_params)
      redirect_to manage_presentations_path
    end

    private

      def create_presentation_params
        params.require(:presentation).permit(:original_file)
      end

      def update_presentation_params
        params.require(:presentation).permit(:is_public)
      end
  end
end
