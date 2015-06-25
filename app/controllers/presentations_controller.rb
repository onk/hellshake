class PresentationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index, :show]

  def index
    @presentations = if @user
                       @user.presentations.all
                     else
                       Presentation.all
                     end
  end

  def show
    @presentation = @user.presentations.find(params[:id])
  end

  def create
    presentation = current_user.presentations.create(presentation_params)
    Ppt2pdfJob.perform_later(presentation)
    redirect_to public_presentation_path(current_user.username, presentation)
  end

  def search
    search_param = { query: { match: { body: { query: params[:q], operator: "and" } } } }
    presentation_ids = PresentationOutline.search(search_param).map(&:presentation_id)
    @presentations = Presentation.ordered_find(presentation_ids)
    render "index"
  end

  private

    def set_user
      if params[:username]
        @user = User.find_by!(username: params[:username])
      end
    end

    def presentation_params
      params.require(:presentation).permit(:original_file)
    end
end
