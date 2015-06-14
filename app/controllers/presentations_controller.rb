class PresentationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index, :show]

  def index
    @presentations = @user.presentations.all

    if current_user
      @presentation = current_user.presentations.new
    end
  end

  def show
    @presentation = @user.presentations.find(params[:id])
  end

  def create
    presentation = current_user.presentations.create(presentation_params)
    Ppt2pdfJob.perform_later(presentation)
    redirect_to presentation_path(current_user.username, presentation)
  end

  private

    def set_user
      @user = User.find_by!(username: params[:username])
    end

    def presentation_params
      params.require(:presentation).permit(:original_file)
    end
end
